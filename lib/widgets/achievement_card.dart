import 'package:flutter/material.dart';
import '../models/achievement.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: achievement.isUnlocked ? 4 : 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          gradient: achievement.isUnlocked
              ? LinearGradient(
                  colors: [
                    _getRarityColor(achievement.rarity).withOpacity(0.1),
                    _getRarityColor(achievement.rarity).withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: achievement.isUnlocked
              ? Border.all(
                  color: _getRarityColor(achievement.rarity).withOpacity(0.3),
                  width: 2,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Achievement icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: achievement.isUnlocked
                      ? _getRarityColor(achievement.rarity)
                      : AppColors.textDisabled,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: achievement.isUnlocked
                      ? [
                          BoxShadow(
                            color: _getRarityColor(achievement.rarity).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    achievement.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Achievement details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and rarity
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            achievement.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: achievement.isUnlocked
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (achievement.isUnlocked)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Description
                    Text(
                      achievement.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: achievement.isUnlocked
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Progress bar
                    if (!achievement.isUnlocked && achievement.currentProgress > 0) ...[
                      Row(
                        children: [
                          Text(
                            '${achievement.currentProgress}/${achievement.targetValue}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${(achievement.progressPercentage * 100).round()}%',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: achievement.progressPercentage,
                        backgroundColor: AppColors.border,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getRarityColor(achievement.rarity),
                        ),
                      ),
                    ] else if (achievement.isUnlocked) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.bolt,
                            size: 16,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '+${achievement.xpReward} XP',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          if (achievement.unlockedAt != null)
                            Text(
                              _formatDate(achievement.unlockedAt!),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        'Not started',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textDisabled,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }
}
