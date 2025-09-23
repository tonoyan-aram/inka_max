import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gratitude_entry.dart';
import '../models/achievement.dart';
import '../services/database_service.dart';
import '../services/achievement_service.dart';
import '../constants/app_constants.dart';

class GratitudeProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final AchievementService _achievementService = AchievementService();
  
  List<GratitudeEntry> _entries = [];
  bool _isLoading = false;
  bool _animationsEnabled = true;
  int _currentStreak = 0;
  Map<GratitudeTag, int> _tagStatistics = {};
  List<Achievement> _newAchievements = [];

  // Getters
  List<GratitudeEntry> get entries => _entries;
  bool get isLoading => _isLoading;
  bool get animationsEnabled => _animationsEnabled;
  int get currentStreak => _currentStreak;
  Map<GratitudeTag, int> get tagStatistics => _tagStatistics;
  int get totalEntries => _entries.length;
  List<Achievement> get newAchievements => _newAchievements;
  AchievementService get achievementService => _achievementService;

  // Initialize the provider
  Future<void> initialize() async {
    await _loadSettings();
    await _achievementService.initialize();
    
    // Delete old database to recreate with correct schema
    try {
      await _databaseService.deleteOldDatabase();
    } catch (e) {
      debugPrint('Error deleting old database: $e');
    }
    
    await loadEntries();
  }

  // Load entries from database
  Future<void> loadEntries() async {
    _isLoading = true;
    notifyListeners();

    try {
      _entries = await _databaseService.getAllEntries();
      _currentStreak = await _databaseService.getCurrentStreak();
      _tagStatistics = await _databaseService.getTagStatistics();
    } catch (e) {
      debugPrint('Error loading entries: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add new entry
  Future<bool> addEntry(String text, List<GratitudeTag> tags) async {
    if (text.trim().isEmpty) return false;

    try {
      final entry = GratitudeEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text.trim(),
        tags: tags,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _databaseService.insertEntry(entry);
      await loadEntries(); // Reload to get updated data
      
      // Check achievements
      final newAchievements = await _achievementService.checkAchievements(
        allEntries: _entries,
        newEntry: entry,
        currentStreak: _currentStreak,
      );
      
      if (newAchievements.isNotEmpty) {
        _newAchievements = newAchievements;
        notifyListeners();
      }
      
      return true;
    } catch (e) {
      debugPrint('Error adding entry: $e');
      return false;
    }
  }

  // Update entry
  Future<bool> updateEntry(GratitudeEntry entry) async {
    try {
      final updatedEntry = entry.copyWith(updatedAt: DateTime.now());
      await _databaseService.updateEntry(updatedEntry);
      await loadEntries();
      return true;
    } catch (e) {
      debugPrint('Error updating entry: $e');
      return false;
    }
  }

  // Delete entry
  Future<bool> deleteEntry(String id) async {
    try {
      await _databaseService.deleteEntry(id);
      await loadEntries();
      return true;
    } catch (e) {
      debugPrint('Error deleting entry: $e');
      return false;
    }
  }

  // Delete all entries
  Future<bool> deleteAllEntries() async {
    try {
      await _databaseService.deleteAllEntries();
      await loadEntries();
      return true;
    } catch (e) {
      debugPrint('Error deleting all entries: $e');
      return false;
    }
  }

  // Get entries by tag
  Future<List<GratitudeEntry>> getEntriesByTag(GratitudeTag tag) async {
    try {
      return await _databaseService.getEntriesByTag(tag);
    } catch (e) {
      debugPrint('Error getting entries by tag: $e');
      return [];
    }
  }

  // Get entries by date range
  Future<List<GratitudeEntry>> getEntriesByDateRange(DateTime start, DateTime end) async {
    try {
      return await _databaseService.getEntriesByDateRange(start, end);
    } catch (e) {
      debugPrint('Error getting entries by date range: $e');
      return [];
    }
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _animationsEnabled = prefs.getBool(AppConstants.keyAnimationsEnabled) ?? true;
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyAnimationsEnabled, _animationsEnabled);
    } catch (e) {
      debugPrint('Error saving settings: $e');
    }
  }

  // Toggle animations
  Future<void> toggleAnimations() async {
    _animationsEnabled = !_animationsEnabled;
    await _saveSettings();
    notifyListeners();
  }

  // Export entries to JSON
  Future<String> exportEntries() async {
    try {
      final entriesJson = _entries.map((entry) => entry.toJson()).toList();
      return entriesJson.toString();
    } catch (e) {
      debugPrint('Error exporting entries: $e');
      return '';
    }
  }

  // Get entries for current month
  List<GratitudeEntry> getCurrentMonthEntries() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    
    return _entries.where((entry) {
      return entry.createdAt.isAfter(startOfMonth) && 
             entry.createdAt.isBefore(endOfMonth);
    }).toList();
  }

  // Get entries for current week
  List<GratitudeEntry> getCurrentWeekEntries() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return _entries.where((entry) {
      return entry.createdAt.isAfter(startOfWeek) && 
             entry.createdAt.isBefore(endOfWeek);
    }).toList();
  }

  // Get entries for today
  List<GratitudeEntry> getTodayEntries() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return _entries.where((entry) {
      return entry.createdAt.isAfter(startOfDay) && 
             entry.createdAt.isBefore(endOfDay);
    }).toList();
  }

  // Get most used tags
  List<MapEntry<GratitudeTag, int>> getMostUsedTags() {
    final sortedTags = _tagStatistics.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedTags;
  }

  // Check if user has entries for today
  bool hasEntryForToday() {
    return getTodayEntries().isNotEmpty;
  }

  // Get total days with entries
  int getTotalDaysWithEntries() {
    final uniqueDays = _entries
        .map((entry) => DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day))
        .toSet();
    return uniqueDays.length;
  }

  // Clear new achievements
  void clearNewAchievements() {
    _newAchievements.clear();
    notifyListeners();
  }
}
