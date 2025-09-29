import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_theme.dart';
import '../constants/predefined_themes.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  AppThemeData _currentTheme = PredefinedThemes.lightTheme;
  final StreamController<AppThemeData> _themeController =
      StreamController<AppThemeData>.broadcast();

  // Getters
  AppThemeData get currentTheme => _currentTheme;
  Stream<AppThemeData> get themeStream => _themeController.stream;

  // Initialize the service
  Future<void> initialize() async {
    await _loadTheme();
  }

  // Load theme from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeId = prefs.getString('selected_theme_id') ?? 'light';

      final theme = PredefinedThemes.getThemeById(themeId);
      if (theme != null) {
        _currentTheme = theme;
        _themeController.add(_currentTheme);
      }
    } catch (e) {
      print('Error loading theme: $e');
      _currentTheme = PredefinedThemes.lightTheme;
      _themeController.add(_currentTheme);
    }
  }

  // Save theme to SharedPreferences
  Future<void> _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_theme_id', _currentTheme.id);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }

  // Change theme
  Future<void> changeTheme(AppThemeData theme) async {
    _currentTheme = theme;
    await _saveTheme();
    _themeController.add(_currentTheme);
  }

  // Get all available themes
  List<AppThemeData> getAllThemes() {
    return PredefinedThemes.allThemes;
  }

  // Get themes by type
  List<AppThemeData> getThemesByType(ThemeType type) {
    return PredefinedThemes.getThemesByType(type);
  }

  // Get seasonal themes
  List<AppThemeData> getSeasonalThemes() {
    return PredefinedThemes.getSeasonalThemes();
  }

  // Get premium themes
  List<AppThemeData> getPremiumThemes() {
    return PredefinedThemes.getPremiumThemes();
  }

  // Get free themes
  List<AppThemeData> getFreeThemes() {
    return PredefinedThemes.getFreeThemes();
  }

  // Get theme by ID
  AppThemeData? getThemeById(String id) {
    return PredefinedThemes.getThemeById(id);
  }

  // Check if theme is premium
  bool isThemePremium(String themeId) {
    final theme = getThemeById(themeId);
    return theme?.isPremium ?? false;
  }

  // Get current theme type
  ThemeType get currentThemeType => _currentTheme.type;

  // Check if current theme is dark
  bool get isDarkTheme => _currentTheme.type == ThemeType.dark;

  // Check if current theme is seasonal
  bool get isSeasonalTheme => _currentTheme.type == ThemeType.seasonal;

  // Get seasonal theme type
  SeasonalTheme? get seasonalType => _currentTheme.seasonalType;

  // Convert AppThemeData to Flutter ThemeData
  ThemeData toFlutterTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _currentTheme.colors.primary,
        secondary: _currentTheme.colors.secondary,
        surface: _currentTheme.colors.surface,
        background: _currentTheme.colors.background,
        onPrimary: _currentTheme.colors.onPrimary,
        onSecondary: _currentTheme.colors.onSecondary,
        onSurface: _currentTheme.colors.onSurface,
        onBackground: _currentTheme.colors.onBackground,
        error: _currentTheme.colors.error,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: _currentTheme.colors.background,
        foregroundColor: _currentTheme.colors.onBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              _currentTheme.colors.background.computeLuminance() > 0.5
              ? Brightness.dark
              : Brightness.light,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: _currentTheme.colors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _currentTheme.colors.primary,
          foregroundColor: _currentTheme.colors.onPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 48),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _currentTheme.colors.primary,
          side: BorderSide(color: _currentTheme.colors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 48),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _currentTheme.colors.primary,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _currentTheme.colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _currentTheme.colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _currentTheme.colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: _currentTheme.colors.borderFocused,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _currentTheme.colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _currentTheme.colors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: TextStyle(color: _currentTheme.colors.textDisabled),
        labelStyle: TextStyle(color: _currentTheme.colors.textSecondary),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: _currentTheme.colors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: _currentTheme.colors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: _currentTheme.colors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Icon theme
      iconTheme: IconThemeData(
        color: _currentTheme.colors.textPrimary,
        size: 24,
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _currentTheme.colors.primary,
        foregroundColor: _currentTheme.colors.onPrimary,
        elevation: 4,
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return _currentTheme.colors.primary;
          }
          return _currentTheme.colors.textDisabled;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return _currentTheme.colors.primary.withOpacity(0.3);
          }
          return _currentTheme.colors.border;
        }),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: _currentTheme.colors.border,
        thickness: 1,
        space: 1,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _currentTheme.colors.background,
        selectedItemColor: _currentTheme.colors.primary,
        unselectedItemColor: _currentTheme.colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Scaffold background
      scaffoldBackgroundColor: _currentTheme.colors.background,
    );
  }

  // Dispose streams
  void dispose() {
    _themeController.close();
  }
}
