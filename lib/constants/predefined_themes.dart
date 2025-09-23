import 'package:flutter/material.dart';
import '../models/app_theme.dart';

class PredefinedThemes {
  // Light Theme (Default)
  static const AppThemeData lightTheme = AppThemeData(
    id: 'light',
    name: 'Light',
    description: 'Clean and bright interface',
    icon: '☀️',
    type: ThemeType.light,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFFFF6B35), // Orange
      secondary: Color(0xFF000000), // Black
      background: Color(0xFFFFFFFF), // White
      surface: Color(0xFFF5F5F5), // Light gray
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFF000000), // Black
      onSurface: Color(0xFF000000), // Black
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF4CAF50), // Green
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFF000000), // Black
      textSecondary: Color(0xFF666666), // Gray
      textDisabled: Color(0xFF999999), // Light gray
      border: Color(0xFFE0E0E0), // Light gray
      borderFocused: Color(0xFFFF6B35), // Orange
      shadow: Color(0x1A000000), // Black with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFFFF6B35), Color(0xFFFF8A65)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFF000000), Color(0xFF424242)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFF5F5F5)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFF5F5F5), Color(0xFFEEEEEE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Dark Theme
  static const AppThemeData darkTheme = AppThemeData(
    id: 'dark',
    name: 'Dark',
    description: 'Elegant dark interface',
    icon: '🌙',
    type: ThemeType.dark,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFFFF6B35), // Orange
      secondary: Color(0xFFFFFFFF), // White
      background: Color(0xFF121212), // Dark
      surface: Color(0xFF1E1E1E), // Dark gray
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFF000000), // Black
      onBackground: Color(0xFFFFFFFF), // White
      onSurface: Color(0xFFFFFFFF), // White
      error: Color(0xFFCF6679), // Light red
      success: Color(0xFF81C784), // Light green
      warning: Color(0xFFFFB74D), // Light orange
      info: Color(0xFF64B5F6), // Light blue
      textPrimary: Color(0xFFFFFFFF), // White
      textSecondary: Color(0xFFB0B0B0), // Light gray
      textDisabled: Color(0xFF666666), // Gray
      border: Color(0xFF333333), // Dark gray
      borderFocused: Color(0xFFFF6B35), // Orange
      shadow: Color(0x1AFFFFFF), // White with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFFFF6B35), Color(0xFFFF8A65)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFE0E0E0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFF1E1E1E), Color(0xFF2C2C2C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1AFFFFFF),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1AFFFFFF),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1AFFFFFF),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1AFFFFFF),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Spring Theme
  static const AppThemeData springTheme = AppThemeData(
    id: 'spring',
    name: 'Spring',
    description: 'Fresh and blooming colors',
    icon: '🌸',
    type: ThemeType.seasonal,
    seasonalType: SeasonalTheme.spring,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFF4CAF50), // Green
      secondary: Color(0xFFE91E63), // Pink
      background: Color(0xFFFFF8E1), // Light yellow
      surface: Color(0xFFF1F8E9), // Light green
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFF2E7D32), // Dark green
      onSurface: Color(0xFF2E7D32), // Dark green
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF4CAF50), // Green
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFF2E7D32), // Dark green
      textSecondary: Color(0xFF558B2F), // Medium green
      textDisabled: Color(0xFF8BC34A), // Light green
      border: Color(0xFFC8E6C9), // Light green
      borderFocused: Color(0xFF4CAF50), // Green
      shadow: Color(0x1A4CAF50), // Green with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFFE91E63), Color(0xFFF8BBD9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFF1F8E9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFF1F8E9), Color(0xFFE8F5E8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1A4CAF50),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1A4CAF50),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1A4CAF50),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1A4CAF50),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Summer Theme
  static const AppThemeData summerTheme = AppThemeData(
    id: 'summer',
    name: 'Summer',
    description: 'Bright and energetic colors',
    icon: '☀️',
    type: ThemeType.seasonal,
    seasonalType: SeasonalTheme.summer,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFFFF9800), // Orange
      secondary: Color(0xFF2196F3), // Blue
      background: Color(0xFFFFF3E0), // Light orange
      surface: Color(0xFFFFE0B2), // Light orange
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFFE65100), // Dark orange
      onSurface: Color(0xFFE65100), // Dark orange
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF4CAF50), // Green
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFFE65100), // Dark orange
      textSecondary: Color(0xFFFF8F00), // Medium orange
      textDisabled: Color(0xFFFFB74D), // Light orange
      border: Color(0xFFFFCC80), // Light orange
      borderFocused: Color(0xFFFF9800), // Orange
      shadow: Color(0x1AFF9800), // Orange with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1AFF9800),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1AFF9800),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1AFF9800),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1AFF9800),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Autumn Theme
  static const AppThemeData autumnTheme = AppThemeData(
    id: 'autumn',
    name: 'Autumn',
    description: 'Warm and cozy colors',
    icon: '🍂',
    type: ThemeType.seasonal,
    seasonalType: SeasonalTheme.autumn,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFFFF5722), // Deep orange
      secondary: Color(0xFF795548), // Brown
      background: Color(0xFFFFF8F5), // Light orange
      surface: Color(0xFFFFF3E0), // Light orange
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFFD84315), // Dark orange
      onSurface: Color(0xFFD84315), // Dark orange
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF4CAF50), // Green
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFFD84315), // Dark orange
      textSecondary: Color(0xFFFF7043), // Medium orange
      textDisabled: Color(0xFFFFAB91), // Light orange
      border: Color(0xFFFFCCBC), // Light orange
      borderFocused: Color(0xFFFF5722), // Deep orange
      shadow: Color(0x1AFF5722), // Deep orange with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFFFF5722), Color(0xFFFF7043)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFF795548), Color(0xFFA1887F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFFFF8F5), Color(0xFFFFF3E0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1AFF5722),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1AFF5722),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1AFF5722),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1AFF5722),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Winter Theme
  static const AppThemeData winterTheme = AppThemeData(
    id: 'winter',
    name: 'Winter',
    description: 'Cool and serene colors',
    icon: '❄️',
    type: ThemeType.seasonal,
    seasonalType: SeasonalTheme.winter,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFF2196F3), // Blue
      secondary: Color(0xFF607D8B), // Blue gray
      background: Color(0xFFF5F5F5), // Light gray
      surface: Color(0xFFE3F2FD), // Light blue
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFF1565C0), // Dark blue
      onSurface: Color(0xFF1565C0), // Dark blue
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF4CAF50), // Green
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFF1565C0), // Dark blue
      textSecondary: Color(0xFF1976D2), // Medium blue
      textDisabled: Color(0xFF64B5F6), // Light blue
      border: Color(0xFFBBDEFB), // Light blue
      borderFocused: Color(0xFF2196F3), // Blue
      shadow: Color(0x1A2196F3), // Blue with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFF607D8B), Color(0xFF90A4AE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFF5F5F5), Color(0xFFE3F2FD)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1A2196F3),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1A2196F3),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1A2196F3),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1A2196F3),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Premium Themes
  static const AppThemeData premiumPurple = AppThemeData(
    id: 'premium_purple',
    name: 'Purple Dreams',
    description: 'Elegant purple gradient theme',
    icon: '💜',
    type: ThemeType.custom,
    isCustom: false,
    isPremium: true,
    colors: AppThemeColors(
      primary: Color(0xFF9C27B0), // Purple
      secondary: Color(0xFF673AB7), // Deep purple
      background: Color(0xFFF3E5F5), // Light purple
      surface: Color(0xFFE1BEE7), // Light purple
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFF4A148C), // Dark purple
      onSurface: Color(0xFF4A148C), // Dark purple
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF4CAF50), // Green
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFF4A148C), // Dark purple
      textSecondary: Color(0xFF7B1FA2), // Medium purple
      textDisabled: Color(0xFFBA68C8), // Light purple
      border: Color(0xFFCE93D8), // Light purple
      borderFocused: Color(0xFF9C27B0), // Purple
      shadow: Color(0x1A9C27B0), // Purple with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFF9C27B0), Color(0xFFE1BEE7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFF673AB7), Color(0xFF9C27B0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFE1BEE7), Color(0xFFCE93D8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Get all predefined themes
  static List<AppThemeData> get allThemes => [
    lightTheme,
    darkTheme,
    springTheme,
    summerTheme,
    autumnTheme,
    winterTheme,
    premiumPurple,
  ];

  // Get themes by type
  static List<AppThemeData> getThemesByType(ThemeType type) {
    return allThemes.where((theme) => theme.type == type).toList();
  }

  // Get seasonal themes
  static List<AppThemeData> getSeasonalThemes() {
    return allThemes.where((theme) => theme.type == ThemeType.seasonal).toList();
  }

  // Get premium themes
  static List<AppThemeData> getPremiumThemes() {
    return allThemes.where((theme) => theme.isPremium).toList();
  }

  // Get free themes
  static List<AppThemeData> getFreeThemes() {
    return allThemes.where((theme) => !theme.isPremium).toList();
  }

  // Get theme by ID
  static AppThemeData? getThemeById(String id) {
    try {
      return allThemes.firstWhere((theme) => theme.id == id);
    } catch (e) {
      return null;
    }
  }
}
