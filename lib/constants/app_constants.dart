class AppConstants {
  // App info
  static const String appName = 'Inka Max';
  static const String appVersion = '1.0.0';
  static const String appMotto = 'Cultivate gratitude, one cluck at a time';
  
  // Database
  static const String databaseName = 'inka_max.db';
  static const int databaseVersion = 1;
  static const String entriesTableName = 'gratitude_entries';
  
  // SharedPreferences keys
  static const String keyAnimationsEnabled = 'animations_enabled';
  static const String keyFirstLaunch = 'first_launch';
  static const String keyStreakCount = 'streak_count';
  static const String keyLastEntryDate = 'last_entry_date';
  
  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);
  
  // UI constants
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double buttonHeight = 48.0;
  static const double iconSize = 24.0;
  static const double largeIconSize = 32.0;
  
  // Text limits
  static const int maxGratitudeTextLength = 500;
  static const int maxTagsPerEntry = 5;
  
  // Export
  static const String exportFileName = 'gratitude_entries_export.json';
  static const String exportDateFormat = 'yyyy-MM-dd_HH-mm-ss';
}
