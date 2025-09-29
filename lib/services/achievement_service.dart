import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/achievement.dart';
import '../models/gratitude_entry.dart';
import '../constants/achievements.dart';

class AchievementService {
  static final AchievementService _instance = AchievementService._internal();
  factory AchievementService() => _instance;
  AchievementService._internal();

  List<Achievement> _achievements = [];
  UserLevel _userLevel = const UserLevel(
    level: 1,
    currentXp: 0,
    xpToNextLevel: 100,
    totalXp: 0,
  );
  final StreamController<List<Achievement>> _achievementsController =
      StreamController<List<Achievement>>.broadcast();
  final StreamController<UserLevel> _userLevelController =
      StreamController<UserLevel>.broadcast();
  final StreamController<Achievement> _newAchievementController =
      StreamController<Achievement>.broadcast();

  // Getters
  List<Achievement> get achievements => _achievements;
  UserLevel get userLevel => _userLevel;
  Stream<List<Achievement>> get achievementsStream =>
      _achievementsController.stream;
  Stream<UserLevel> get userLevelStream => _userLevelController.stream;
  Stream<Achievement> get newAchievementStream =>
      _newAchievementController.stream;

  // Initialize the service
  Future<void> initialize() async {
    await _loadAchievements();
    await _loadUserLevel();
  }

  // Load achievements from SharedPreferences
  Future<void> _loadAchievements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final achievementsJson = prefs.getString('achievements') ?? '[]';
      final List<dynamic> achievementsList = json.decode(achievementsJson);

      if (achievementsList.isEmpty) {
        // Initialize with predefined achievements
        _achievements = List.from(AchievementConstants.predefinedAchievements);
        await _saveAchievements();
      } else {
        _achievements = achievementsList
            .map((json) => Achievement.fromJson(json))
            .toList();
      }

      _achievementsController.add(_achievements);
    } catch (e) {
      print('Error loading achievements: $e');
      _achievements = List.from(AchievementConstants.predefinedAchievements);
      await _saveAchievements();
    }
  }

  // Save achievements to SharedPreferences
  Future<void> _saveAchievements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final achievementsJson = json.encode(
        _achievements.map((a) => a.toJson()).toList(),
      );
      await prefs.setString('achievements', achievementsJson);
    } catch (e) {
      print('Error saving achievements: $e');
    }
  }

  // Load user level from SharedPreferences
  Future<void> _loadUserLevel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final totalXp = prefs.getInt('total_xp') ?? 0;
      _userLevel = AchievementConstants.calculateUserLevel(totalXp);
      _userLevelController.add(_userLevel);
    } catch (e) {
      print('Error loading user level: $e');
      _userLevel = const UserLevel(
        level: 1,
        currentXp: 0,
        xpToNextLevel: 100,
        totalXp: 0,
      );
    }
  }

  // Save user level to SharedPreferences
  Future<void> _saveUserLevel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('total_xp', _userLevel.totalXp);
    } catch (e) {
      print('Error saving user level: $e');
    }
  }

  // Check and update achievements based on new entry
  Future<List<Achievement>> checkAchievements({
    required List<GratitudeEntry> allEntries,
    required GratitudeEntry? newEntry,
    required int currentStreak,
  }) async {
    List<Achievement> newlyUnlocked = [];

    for (int i = 0; i < _achievements.length; i++) {
      final achievement = _achievements[i];
      if (achievement.isUnlocked) continue;

      bool shouldUnlock = false;
      int newProgress = 0;

      switch (achievement.type) {
        case AchievementType.count:
          newProgress = allEntries.length;
          shouldUnlock = newProgress >= achievement.targetValue;
          break;

        case AchievementType.streak:
          newProgress = currentStreak;
          shouldUnlock = newProgress >= achievement.targetValue;
          break;

        case AchievementType.tag:
          if (achievement.tag != null) {
            newProgress = allEntries
                .where(
                  (entry) =>
                      entry.tags.any((tag) => tag.name == achievement.tag),
                )
                .length;
            shouldUnlock = newProgress >= achievement.targetValue;
          }
          break;

        case AchievementType.special:
          shouldUnlock = _checkSpecialAchievement(
            achievement,
            allEntries,
            newEntry,
          );
          newProgress = shouldUnlock ? 1 : 0;
          break;
      }

      if (newProgress != achievement.currentProgress || shouldUnlock) {
        _achievements[i] = achievement.copyWith(
          currentProgress: newProgress,
          isUnlocked: shouldUnlock,
          unlockedAt: shouldUnlock ? DateTime.now() : achievement.unlockedAt,
        );

        if (shouldUnlock) {
          newlyUnlocked.add(_achievements[i]);
          await _addXp(achievement.xpReward);
        }
      }
    }

    if (newlyUnlocked.isNotEmpty) {
      await _saveAchievements();
      _achievementsController.add(_achievements);

      // Notify about new achievements
      for (final achievement in newlyUnlocked) {
        _newAchievementController.add(achievement);
      }
    }

    return newlyUnlocked;
  }

  // Check special achievements
  bool _checkSpecialAchievement(
    Achievement achievement,
    List<GratitudeEntry> allEntries,
    GratitudeEntry? newEntry,
  ) {
    switch (achievement.id) {
      case 'all_tags':
        final usedTags = allEntries
            .expand((entry) => entry.tags)
            .map((tag) => tag.name)
            .toSet();
        return usedTags.length >= 5;

      case 'long_entry':
        if (newEntry == null) return false;
        return newEntry.text.length >= 100;

      case 'early_bird':
        if (newEntry == null) return false;
        return newEntry.createdAt.hour < 8;

      case 'night_owl':
        if (newEntry == null) return false;
        return newEntry.createdAt.hour >= 22;

      default:
        return false;
    }
  }

  // Add XP and update level
  Future<void> _addXp(int xp) async {
    final newTotalXp = _userLevel.totalXp + xp;
    final newLevel = AchievementConstants.calculateUserLevel(newTotalXp);

    _userLevel = newLevel;
    await _saveUserLevel();
    _userLevelController.add(_userLevel);
  }

  // Get achievements by rarity
  List<Achievement> getAchievementsByRarity(AchievementRarity rarity) {
    return _achievements.where((a) => a.rarity == rarity).toList();
  }

  // Get unlocked achievements
  List<Achievement> getUnlockedAchievements() {
    return _achievements.where((a) => a.isUnlocked).toList();
  }

  // Get locked achievements
  List<Achievement> getLockedAchievements() {
    return _achievements.where((a) => !a.isUnlocked).toList();
  }

  // Get achievements by type
  List<Achievement> getAchievementsByType(AchievementType type) {
    return _achievements.where((a) => a.type == type).toList();
  }

  // Get achievement by ID
  Achievement? getAchievementById(String id) {
    try {
      return _achievements.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get progress statistics
  Map<String, dynamic> getProgressStats() {
    final unlocked = getUnlockedAchievements();
    final total = _achievements.length;
    final byRarity = <AchievementRarity, int>{};
    final byType = <AchievementType, int>{};

    for (final achievement in unlocked) {
      byRarity[achievement.rarity] = (byRarity[achievement.rarity] ?? 0) + 1;
      byType[achievement.type] = (byType[achievement.type] ?? 0) + 1;
    }

    return {
      'totalAchievements': total,
      'unlockedAchievements': unlocked.length,
      'completionPercentage': total > 0
          ? (unlocked.length / total * 100).round()
          : 0,
      'byRarity': byRarity,
      'byType': byType,
      'userLevel': _userLevel.level,
      'totalXp': _userLevel.totalXp,
    };
  }

  // Reset all achievements (for testing)
  Future<void> resetAchievements() async {
    _achievements = List.from(AchievementConstants.predefinedAchievements);
    _userLevel = const UserLevel(
      level: 1,
      currentXp: 0,
      xpToNextLevel: 100,
      totalXp: 0,
    );

    await _saveAchievements();
    await _saveUserLevel();

    _achievementsController.add(_achievements);
    _userLevelController.add(_userLevel);
  }

  // Dispose streams
  void dispose() {
    _achievementsController.close();
    _userLevelController.close();
    _newAchievementController.close();
  }
}
