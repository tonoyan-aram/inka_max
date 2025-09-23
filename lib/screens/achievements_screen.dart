import 'package:flutter/material.dart';
import '../models/achievement.dart';
import '../services/achievement_service.dart';
import '../constants/app_colors.dart';
import '../widgets/achievement_card.dart';
import '../widgets/level_progress_widget.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AchievementService _achievementService = AchievementService();

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Achievements'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All', icon: Icon(Icons.all_inclusive)),
            Tab(text: 'Unlocked', icon: Icon(Icons.check_circle)),
            Tab(text: 'Progress', icon: Icon(Icons.trending_up)),
            Tab(text: 'Stats', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: StreamBuilder<List<Achievement>>(
        stream: _achievementService.achievementsStream,
        builder: (context, achievementsSnapshot) {
          if (!achievementsSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final achievements = achievementsSnapshot.data!;

          return TabBarView(
            controller: _tabController,
            children: [
              _buildAllAchievementsTab(achievements),
              _buildUnlockedTab(achievements),
              _buildProgressTab(achievements),
              _buildStatsTab(achievements),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAllAchievementsTab(List<Achievement> achievements) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level progress
          StreamBuilder<UserLevel>(
            stream: _achievementService.userLevelStream,
            builder: (context, levelSnapshot) {
              if (levelSnapshot.hasData) {
                return LevelProgressWidget(level: levelSnapshot.data!);
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 24),

          // Achievements by rarity
          ...AchievementRarity.values.map((rarity) {
            final rarityAchievements = achievements
                .where((a) => a.rarity == rarity)
                .toList();
            if (rarityAchievements.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRarityHeader(rarity),
                const SizedBox(height: 12),
                ...rarityAchievements.map(
                  (achievement) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AchievementCard(achievement: achievement),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildUnlockedTab(List<Achievement> achievements) {
    final unlockedAchievements = achievements
        .where((a) => a.isUnlocked)
        .toList();

    if (unlockedAchievements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 80, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              'No achievements unlocked yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start writing gratitude entries to unlock your first achievement!',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: unlockedAchievements.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AchievementCard(achievement: unlockedAchievements[index]),
        );
      },
    );
  }

  Widget _buildProgressTab(List<Achievement> achievements) {
    final inProgressAchievements = achievements
        .where((a) => !a.isUnlocked && a.currentProgress > 0)
        .toList();

    if (inProgressAchievements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.trending_up, size: 80, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              'No achievements in progress',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Keep writing gratitude entries to make progress on achievements!',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: inProgressAchievements.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AchievementCard(achievement: inProgressAchievements[index]),
        );
      },
    );
  }

  Widget _buildStatsTab(List<Achievement> achievements) {
    final stats = _achievementService.getProgressStats();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall progress
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          'Unlocked',
                          '${stats['unlockedAchievements']}/${stats['totalAchievements']}',
                          Icons.check_circle,
                          AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatItem(
                          'Completion',
                          '${stats['completionPercentage']}%',
                          Icons.percent,
                          AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Level info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Level',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          'Current Level',
                          '${stats['userLevel']}',
                          Icons.star,
                          AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatItem(
                          'Total XP',
                          '${stats['totalXp']}',
                          Icons.bolt,
                          AppColors.info,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Achievements by rarity
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achievements by Rarity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ...AchievementRarity.values.map((rarity) {
                    final count = stats['byRarity'][rarity] ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            _getRarityIcon(rarity),
                            color: _getRarityColor(rarity),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(_getRarityName(rarity)),
                          const Spacer(),
                          Text(
                            count.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getRarityColor(rarity),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Achievements by type
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achievements by Type',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ...AchievementType.values.map((type) {
                    final count = stats['byType'][type] ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            _getTypeIcon(type),
                            color: _getTypeColor(type),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(_getTypeName(type)),
                          const Spacer(),
                          Text(
                            count.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getTypeColor(type),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRarityHeader(AchievementRarity rarity) {
    return Row(
      children: [
        Icon(_getRarityIcon(rarity), color: _getRarityColor(rarity), size: 24),
        const SizedBox(width: 8),
        Text(
          _getRarityName(rarity),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: _getRarityColor(rarity),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
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
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  IconData _getRarityIcon(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return Icons.circle;
      case AchievementRarity.rare:
        return Icons.star;
      case AchievementRarity.epic:
        return Icons.diamond;
      case AchievementRarity.legendary:
        return Icons.auto_awesome;
    }
  }

  Color _getRarityColor(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return AppColors.textSecondary;
      case AchievementRarity.rare:
        return AppColors.info;
      case AchievementRarity.epic:
        return AppColors.primary;
      case AchievementRarity.legendary:
        return AppColors.warning;
    }
  }

  String _getRarityName(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return 'Common';
      case AchievementRarity.rare:
        return 'Rare';
      case AchievementRarity.epic:
        return 'Epic';
      case AchievementRarity.legendary:
        return 'Legendary';
    }
  }

  IconData _getTypeIcon(AchievementType type) {
    switch (type) {
      case AchievementType.streak:
        return Icons.local_fire_department;
      case AchievementType.count:
        return Icons.numbers;
      case AchievementType.tag:
        return Icons.label;
      case AchievementType.special:
        return Icons.auto_awesome;
    }
  }

  Color _getTypeColor(AchievementType type) {
    switch (type) {
      case AchievementType.streak:
        return AppColors.warning;
      case AchievementType.count:
        return AppColors.primary;
      case AchievementType.tag:
        return AppColors.info;
      case AchievementType.special:
        return AppColors.success;
    }
  }

  String _getTypeName(AchievementType type) {
    switch (type) {
      case AchievementType.streak:
        return 'Streak';
      case AchievementType.count:
        return 'Count';
      case AchievementType.tag:
        return 'Tag';
      case AchievementType.special:
        return 'Special';
    }
  }
}
