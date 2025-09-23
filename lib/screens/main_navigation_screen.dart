import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/gratitude_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../widgets/achievement_notification.dart';
import 'add_entry_screen.dart';
import 'nest_screen.dart';
import 'insights_screen.dart';
import 'achievements_screen.dart';
import 'themes_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> get _screens => [
    TodayScreen(onMenuTap: () => _scaffoldKey.currentState?.openDrawer()),
    const NestScreen(),
    const InsightsScreen(),
    const AchievementsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          // Achievement notifications
          Consumer<GratitudeProvider>(
            builder: (context, provider, child) {
              if (provider.newAchievements.isNotEmpty) {
                return AchievementNotification(
                  achievement: provider.newAchievements.first,
                  onDismiss: () {
                    provider.clearNewAchievements();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Nest'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Achievements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              heroTag: "today_fab",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddEntryScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      size: 32,
                      color: AppColors.onPrimary,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConstants.appName,
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppConstants.appMotto,
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.today,
                  title: 'Today',
                  subtitle: 'Add your daily gratitude',
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.home,
                  title: 'Nest',
                  subtitle: 'View all your entries',
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.analytics,
                  title: 'Insights',
                  subtitle: 'See your progress',
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.emoji_events,
                  title: 'Achievements',
                  subtitle: 'Unlock rewards and badges',
                  onTap: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.palette,
                  title: 'Themes',
                  subtitle: 'Customize your experience',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ThemesScreen(),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'App preferences',
                  onTap: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  icon: Icons.info,
                  title: 'About',
                  subtitle: 'Learn more about the app',
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAboutDialog();
                  },
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Divider(),
                Text(
                  'Version ${AppConstants.appVersion}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: const Icon(
        Icons.home_outlined,
        size: 48,
        color: AppColors.primary,
      ),
      children: [
        const Text(
          'Inka Max helps you cultivate gratitude by recording what you\'re thankful for each day. '
          'Build a habit of appreciation and watch your positivity grow!',
        ),
      ],
    );
  }
}

class TodayScreen extends StatelessWidget {
  final VoidCallback? onMenuTap;
  
  const TodayScreen({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Today'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuTap,
          ),
        ),
      ),
      body: Consumer<GratitudeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          final todayEntries = provider.getTodayEntries();
          final hasEntryToday = provider.hasEntryForToday();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'What are you grateful for today?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getFormattedDate(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),

                // Today's entries or empty state
                if (hasEntryToday) ...[
                  Text(
                    'Today\'s Gratitude',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...todayEntries
                      .map(
                        (entry) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.text,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                if (entry.tags.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: entry.tags.map((tag) {
                                      final tagColor =
                                          AppColors.tagColors[tag.name] ??
                                          AppColors.primary;
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: tagColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: tagColor.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          tag.displayName,
                                          style: TextStyle(
                                            color: tagColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ] else ...[
                  // Empty state
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.egg_outlined,
                            size: 80,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Your nest is empty',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Add your first gratitude entry to start filling your nest with positivity.',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppColors.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddEntryScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add Your First Entry'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Quick stats
                if (provider.totalEntries > 0) ...[
                  Text(
                    'Your Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Entries',
                          '${provider.totalEntries}',
                          Icons.article,
                          AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Current Streak',
                          '${provider.currentStreak} days',
                          Icons.local_fire_department,
                          AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }
}
