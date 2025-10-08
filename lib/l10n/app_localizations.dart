import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // App name and general
  String get appName => _localizedValues[locale.languageCode]!['app_name']!;
  String get appMotto => _localizedValues[locale.languageCode]!['app_motto']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get yes => _localizedValues[locale.languageCode]!['yes']!;
  String get no => _localizedValues[locale.languageCode]!['no']!;

  // Navigation
  String get today => _localizedValues[locale.languageCode]!['today']!;
  String get nest => _localizedValues[locale.languageCode]!['nest']!;
  String get insights => _localizedValues[locale.languageCode]!['insights']!;
  String get achievements => _localizedValues[locale.languageCode]!['achievements']!;
  String get themes => _localizedValues[locale.languageCode]!['themes']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;

  // Today screen
  String get addDailyGratitude => _localizedValues[locale.languageCode]!['add_daily_gratitude']!;
  String get viewAllEntries => _localizedValues[locale.languageCode]!['view_all_entries']!;
  String get seeYourProgress => _localizedValues[locale.languageCode]!['see_your_progress']!;
  String get unlockRewardsBadges => _localizedValues[locale.languageCode]!['unlock_rewards_badges']!;
  String get customizeExperience => _localizedValues[locale.languageCode]!['customize_experience']!;
  String get appPreferences => _localizedValues[locale.languageCode]!['app_preferences']!;
  String get learnMoreAboutApp => _localizedValues[locale.languageCode]!['learn_more_about_app']!;
  
  // Nest screen
  String get myGratitudeNest => _localizedValues[locale.languageCode]!['my_gratitude_nest']!;
  String get emptyNest => _localizedValues[locale.languageCode]!['empty_nest']!;
  String get emptyNestMessage => _localizedValues[locale.languageCode]!['empty_nest_message']!;
  String get addFirstEntry => _localizedValues[locale.languageCode]!['add_first_entry']!;

  // Add entry screen
  String get newGratitudeEntry => _localizedValues[locale.languageCode]!['new_gratitude_entry']!;
  String get whatAreYouGratefulFor => _localizedValues[locale.languageCode]!['what_are_you_grateful_for']!;
  String get selectTags => _localizedValues[locale.languageCode]!['select_tags']!;
  String get entryCannotBeEmpty => _localizedValues[locale.languageCode]!['entry_cannot_be_empty']!;

  // Tags
  String get health => _localizedValues[locale.languageCode]!['health']!;
  String get family => _localizedValues[locale.languageCode]!['family']!;
  String get work => _localizedValues[locale.languageCode]!['work']!;
  String get nature => _localizedValues[locale.languageCode]!['nature']!;
  String get other => _localizedValues[locale.languageCode]!['other']!;

  // Insights screen
  String get gratitudeInsights => _localizedValues[locale.languageCode]!['gratitude_insights']!;
  String get yourJourney => _localizedValues[locale.languageCode]!['your_journey']!;
  String get totalEntries => _localizedValues[locale.languageCode]!['total_entries']!;
  String get currentStreak => _localizedValues[locale.languageCode]!['current_streak']!;
  String get days => _localizedValues[locale.languageCode]!['days']!;
  String get longestStreak => _localizedValues[locale.languageCode]!['longest_streak']!;
  String get entriesThisMonth => _localizedValues[locale.languageCode]!['entries_this_month']!;
  String get gratitudeOverTime => _localizedValues[locale.languageCode]!['gratitude_over_time']!;
  String get noDataYet => _localizedValues[locale.languageCode]!['no_data_yet']!;
  String get thisWeek => _localizedValues[locale.languageCode]!['this_week']!;
  String get thisMonth => _localizedValues[locale.languageCode]!['this_month']!;
  String get thisYear => _localizedValues[locale.languageCode]!['this_year']!;
  String get allTime => _localizedValues[locale.languageCode]!['all_time']!;
  String get tagDistribution => _localizedValues[locale.languageCode]!['tag_distribution']!;
  String get entriesOverTime => _localizedValues[locale.languageCode]!['entries_over_time']!;
  String get noInsightsYet => _localizedValues[locale.languageCode]!['no_insights_yet']!;
  String get addYourFirstEntry => _localizedValues[locale.languageCode]!['add_your_first_entry']!;
  String get week => _localizedValues[locale.languageCode]!['week']!;
  String get month => _localizedValues[locale.languageCode]!['month']!;
  String get year => _localizedValues[locale.languageCode]!['year']!;
  String get mostUsedTags => _localizedValues[locale.languageCode]!['most_used_tags']!;
  String get recentEntries => _localizedValues[locale.languageCode]!['recent_entries']!;
  String get yesterday => _localizedValues[locale.languageCode]!['yesterday']!;

  // Achievements screen
  String get yourAchievements => _localizedValues[locale.languageCode]!['your_achievements']!;
  String get level => _localizedValues[locale.languageCode]!['level']!;
  String get xpToNextLevel => _localizedValues[locale.languageCode]!['xp_to_next_level']!;
  String get unlocked => _localizedValues[locale.languageCode]!['unlocked']!;
  String get locked => _localizedValues[locale.languageCode]!['locked']!;

  // Settings screen
  String get appSettings => _localizedValues[locale.languageCode]!['app_settings']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get selectLanguage => _localizedValues[locale.languageCode]!['select_language']!;
  String get appearance => _localizedValues[locale.languageCode]!['appearance']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get animations => _localizedValues[locale.languageCode]!['animations']!;
  String get enableAnimations => _localizedValues[locale.languageCode]!['enable_animations']!;
  String get showConfettiOnSave => _localizedValues[locale.languageCode]!['show_confetti_on_save']!;
  String get enableCelebrationAnimations => _localizedValues[locale.languageCode]!['enable_celebration_animations']!;
  String get visuals => _localizedValues[locale.languageCode]!['visuals']!;
  String get dataManagement => _localizedValues[locale.languageCode]!['data_management']!;
  String get data => _localizedValues[locale.languageCode]!['data']!;
  String get exportData => _localizedValues[locale.languageCode]!['export_data']!;
  String get exportMyEntries => _localizedValues[locale.languageCode]!['export_my_entries']!;
  String get downloadEntriesAsJson => _localizedValues[locale.languageCode]!['download_entries_as_json']!;
  String get deleteAllData => _localizedValues[locale.languageCode]!['delete_all_data']!;
  String get deleteAllDataConfirm => _localizedValues[locale.languageCode]!['delete_all_data_confirm']!;
  String get dataExported => _localizedValues[locale.languageCode]!['data_exported']!;
  String get dataDeleted => _localizedValues[locale.languageCode]!['data_deleted']!;
  String get version => _localizedValues[locale.languageCode]!['version']!;

  // Months
  String get january => _localizedValues[locale.languageCode]!['january']!;
  String get february => _localizedValues[locale.languageCode]!['february']!;
  String get march => _localizedValues[locale.languageCode]!['march']!;
  String get april => _localizedValues[locale.languageCode]!['april']!;
  String get may => _localizedValues[locale.languageCode]!['may']!;
  String get june => _localizedValues[locale.languageCode]!['june']!;
  String get july => _localizedValues[locale.languageCode]!['july']!;
  String get august => _localizedValues[locale.languageCode]!['august']!;
  String get september => _localizedValues[locale.languageCode]!['september']!;
  String get october => _localizedValues[locale.languageCode]!['october']!;
  String get november => _localizedValues[locale.languageCode]!['november']!;
  String get december => _localizedValues[locale.languageCode]!['december']!;

  // Get month name by index (1-12)
  String getMonthName(int month) {
    const months = [
      'january', 'february', 'march', 'april', 'may', 'june',
      'july', 'august', 'september', 'october', 'november', 'december'
    ];
    if (month < 1 || month > 12) return '';
    return _localizedValues[locale.languageCode]![months[month - 1]]!;
  }

  // Localized values
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Inka Max',
      'app_motto': 'Cultivate gratitude, one cluck at a time',
      'loading': 'Loading...',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'edit': 'Edit',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      // Navigation
      'today': 'Today',
      'nest': 'Nest',
      'insights': 'Insights',
      'achievements': 'Achievements',
      'themes': 'Themes',
      'settings': 'Settings',
      'about': 'About',
      // Today screen
      'add_daily_gratitude': 'Add your daily gratitude',
      'view_all_entries': 'View all your entries',
      'see_your_progress': 'See your progress',
      'unlock_rewards_badges': 'Unlock rewards and badges',
      'customize_experience': 'Customize your experience',
      'app_preferences': 'App preferences',
      'learn_more_about_app': 'Learn more about the app',
      // Nest screen
      'my_gratitude_nest': 'My Gratitude Nest',
      'empty_nest': 'Your nest is empty',
      'empty_nest_message': 'Start your gratitude journey by adding your first entry!',
      'add_first_entry': 'Add First Entry',
      // Add entry screen
      'new_gratitude_entry': 'New Gratitude Entry',
      'what_are_you_grateful_for': 'What are you grateful for today?',
      'select_tags': 'Select tags (optional)',
      'entry_cannot_be_empty': 'Entry cannot be empty',
      // Tags
      'health': 'Health',
      'family': 'Family',
      'work': 'Work',
      'nature': 'Nature',
      'other': 'Other',
      // Insights screen
      'gratitude_insights': 'Gratitude Insights',
      'your_journey': 'Your Journey',
      'total_entries': 'Total Entries',
      'current_streak': 'Current Streak',
      'days': 'days',
      'longest_streak': 'Longest Streak',
      'entries_this_month': 'Entries This Month',
      'gratitude_over_time': 'Gratitude Over Time',
      'no_data_yet': 'No data yet',
      'this_week': 'This Week',
      'this_month': 'This Month',
      'this_year': 'This Year',
      'all_time': 'All Time',
      'tag_distribution': 'Tag Distribution',
      'entries_over_time': 'Entries Over Time',
      'no_insights_yet': 'No insights yet',
      'add_your_first_entry': 'Add Your First Entry',
      'week': 'Week',
      'month': 'Month',
      'year': 'Year',
      'most_used_tags': 'Most Used Tags',
      'recent_entries': 'Recent Entries',
      'yesterday': 'Yesterday',
      // Achievements screen
      'your_achievements': 'Your Achievements',
      'level': 'Level',
      'xp_to_next_level': 'XP to next level',
      'unlocked': 'Unlocked',
      'locked': 'Locked',
      // Settings screen
      'app_settings': 'App Settings',
      'language': 'Language',
      'select_language': 'Select Language',
      'appearance': 'Appearance',
      'theme': 'Theme',
      'animations': 'Animations',
      'enable_animations': 'Enable Animations',
      'show_confetti_on_save': 'Show confetti on save',
      'enable_celebration_animations': 'Enable celebration animations when saving entries',
      'visuals': 'Visuals',
      'data_management': 'Data Management',
      'data': 'Data',
      'export_data': 'Export Data',
      'export_my_entries': 'Export My Entries',
      'download_entries_as_json': 'Download your gratitude entries as JSON file',
      'delete_all_data': 'Delete All Data',
      'delete_all_data_confirm': 'Are you sure you want to delete all your data? This action cannot be undone.',
      'data_exported': 'Data exported successfully',
      'data_deleted': 'All data has been deleted',
      'version': 'Version',
      // Months
      'january': 'January',
      'february': 'February',
      'march': 'March',
      'april': 'April',
      'may': 'May',
      'june': 'June',
      'july': 'July',
      'august': 'August',
      'september': 'September',
      'october': 'October',
      'november': 'November',
      'december': 'December',
    },
    'es': {
      'app_name': 'Inka Max',
      'app_motto': 'Cultiva la gratitud, un cacareo a la vez',
      'loading': 'Cargando...',
      'save': 'Guardar',
      'cancel': 'Cancelar',
      'delete': 'Eliminar',
      'edit': 'Editar',
      'ok': 'OK',
      'yes': 'Sí',
      'no': 'No',
      // Navigation
      'today': 'Hoy',
      'nest': 'Nido',
      'insights': 'Estadísticas',
      'achievements': 'Logros',
      'themes': 'Temas',
      'settings': 'Ajustes',
      'about': 'Acerca de',
      // Today screen
      'add_daily_gratitude': 'Agrega tu gratitud diaria',
      'view_all_entries': 'Ver todas tus entradas',
      'see_your_progress': 'Ver tu progreso',
      'unlock_rewards_badges': 'Desbloquear recompensas e insignias',
      'customize_experience': 'Personaliza tu experiencia',
      'app_preferences': 'Preferencias de la aplicación',
      'learn_more_about_app': 'Aprende más sobre la aplicación',
      // Nest screen
      'my_gratitude_nest': 'Mi Nido de Gratitud',
      'empty_nest': 'Tu nido está vacío',
      'empty_nest_message': '¡Comienza tu viaje de gratitud agregando tu primera entrada!',
      'add_first_entry': 'Agregar Primera Entrada',
      // Add entry screen
      'new_gratitude_entry': 'Nueva Entrada de Gratitud',
      'what_are_you_grateful_for': '¿Por qué estás agradecido hoy?',
      'select_tags': 'Seleccionar etiquetas (opcional)',
      'entry_cannot_be_empty': 'La entrada no puede estar vacía',
      // Tags
      'health': 'Salud',
      'family': 'Familia',
      'work': 'Trabajo',
      'nature': 'Naturaleza',
      'other': 'Otro',
      // Insights screen
      'gratitude_insights': 'Estadísticas de Gratitud',
      'your_journey': 'Tu Viaje',
      'total_entries': 'Total de Entradas',
      'current_streak': 'Racha Actual',
      'days': 'días',
      'longest_streak': 'Racha Más Larga',
      'entries_this_month': 'Entradas Este Mes',
      'gratitude_over_time': 'Gratitud con el Tiempo',
      'no_data_yet': 'Aún no hay datos',
      'this_week': 'Esta Semana',
      'this_month': 'Este Mes',
      'this_year': 'Este Año',
      'all_time': 'Todo el Tiempo',
      'tag_distribution': 'Distribución de Etiquetas',
      'entries_over_time': 'Entradas con el Tiempo',
      'no_insights_yet': 'Aún no hay estadísticas',
      'add_your_first_entry': 'Agrega Tu Primera Entrada',
      'week': 'Semana',
      'month': 'Mes',
      'year': 'Año',
      'most_used_tags': 'Etiquetas Más Usadas',
      'recent_entries': 'Entradas Recientes',
      'yesterday': 'Ayer',
      // Achievements screen
      'your_achievements': 'Tus Logros',
      'level': 'Nivel',
      'xp_to_next_level': 'XP para el siguiente nivel',
      'unlocked': 'Desbloqueado',
      'locked': 'Bloqueado',
      // Settings screen
      'app_settings': 'Configuración de la App',
      'language': 'Idioma',
      'select_language': 'Seleccionar Idioma',
      'appearance': 'Apariencia',
      'theme': 'Tema',
      'animations': 'Animaciones',
      'enable_animations': 'Habilitar Animaciones',
      'show_confetti_on_save': 'Mostrar confeti al guardar',
      'enable_celebration_animations': 'Habilitar animaciones de celebración al guardar entradas',
      'visuals': 'Visuales',
      'data_management': 'Gestión de Datos',
      'data': 'Datos',
      'export_data': 'Exportar Datos',
      'export_my_entries': 'Exportar Mis Entradas',
      'download_entries_as_json': 'Descarga tus entradas de gratitud como archivo JSON',
      'delete_all_data': 'Eliminar Todos los Datos',
      'delete_all_data_confirm': '¿Estás seguro de que quieres eliminar todos tus datos? Esta acción no se puede deshacer.',
      'data_exported': 'Datos exportados exitosamente',
      'data_deleted': 'Todos los datos han sido eliminados',
      'version': 'Versión',
      // Months
      'january': 'Enero',
      'february': 'Febrero',
      'march': 'Marzo',
      'april': 'Abril',
      'may': 'Mayo',
      'june': 'Junio',
      'july': 'Julio',
      'august': 'Agosto',
      'september': 'Septiembre',
      'october': 'Octubre',
      'november': 'Noviembre',
      'december': 'Diciembre',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
