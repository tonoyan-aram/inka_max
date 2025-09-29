import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../services/theme_service.dart';
import '../constants/predefined_themes.dart';
import '../widgets/theme_card.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ThemeService _themeService = ThemeService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Themes'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All', icon: Icon(Icons.all_inclusive)),
            Tab(text: 'Light', icon: Icon(Icons.light_mode)),
            Tab(text: 'Dark', icon: Icon(Icons.dark_mode)),
            Tab(text: 'Seasonal', icon: Icon(Icons.nature)),
          ],
        ),
      ),
      body: StreamBuilder<AppThemeData>(
        stream: _themeService.themeStream,
        builder: (context, themeSnapshot) {
          final currentTheme =
              themeSnapshot.data ?? PredefinedThemes.lightTheme;

          return TabBarView(
            controller: _tabController,
            children: [
              _buildAllThemesTab(currentTheme),
              _buildThemesByTypeTab(ThemeType.light, currentTheme),
              _buildThemesByTypeTab(ThemeType.dark, currentTheme),
              _buildSeasonalThemesTab(currentTheme),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAllThemesTab(AppThemeData currentTheme) {
    final themes = _themeService.getAllThemes();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: themes.length,
      itemBuilder: (context, index) {
        final theme = themes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ThemeCard(
            theme: theme,
            isSelected: theme.id == currentTheme.id,
            onTap: () => _selectTheme(theme),
          ),
        );
      },
    );
  }

  Widget _buildThemesByTypeTab(ThemeType type, AppThemeData currentTheme) {
    final themes = _themeService.getThemesByType(type);

    if (themes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == ThemeType.light ? Icons.light_mode : Icons.dark_mode,
              size: 80,
              color: currentTheme.colors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No ${type.name} themes available',
              style: TextStyle(
                color: currentTheme.colors.textSecondary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: themes.length,
      itemBuilder: (context, index) {
        final theme = themes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ThemeCard(
            theme: theme,
            isSelected: theme.id == currentTheme.id,
            onTap: () => _selectTheme(theme),
          ),
        );
      },
    );
  }

  Widget _buildSeasonalThemesTab(AppThemeData currentTheme) {
    final themes = _themeService.getSeasonalThemes();

    if (themes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.nature,
              size: 80,
              color: currentTheme.colors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No seasonal themes available',
              style: TextStyle(
                color: currentTheme.colors.textSecondary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: themes.length,
      itemBuilder: (context, index) {
        final theme = themes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ThemeCard(
            theme: theme,
            isSelected: theme.id == currentTheme.id,
            onTap: () => _selectTheme(theme),
          ),
        );
      },
    );
  }

  void _selectTheme(AppThemeData theme) {
    _themeService.changeTheme(theme);

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Theme changed to ${theme.name}'),
        backgroundColor: theme.colors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
