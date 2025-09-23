import '../models/achievement.dart';

class AchievementConstants {
  // XP required for each level (total XP, not XP to next level)
  static const List<int> levelXpRequirements = [
    0,      // Level 1
    100,    // Level 2
    250,    // Level 3
    500,    // Level 4
    1000,   // Level 5
    2000,   // Level 6
    3500,   // Level 7
    5500,   // Level 8
    8000,   // Level 9
    12000,  // Level 10
    17000,  // Level 11
    23000,  // Level 12
    30000,  // Level 13
    38000,  // Level 14
    47000,  // Level 15
    57000,  // Level 16
    68000,  // Level 17
    80000,  // Level 18
    93000,  // Level 19
    107000, // Level 20
  ];

  // Predefined achievements
  static const List<Achievement> predefinedAchievements = [
    // Streak achievements
    Achievement(
      id: 'first_entry',
      title: 'First Steps',
      description: 'Write your first gratitude entry',
      icon: '🌟',
      type: AchievementType.count,
      rarity: AchievementRarity.common,
      targetValue: 1,
      xpReward: 10,
    ),
    Achievement(
      id: 'streak_3',
      title: 'Getting Started',
      description: 'Write gratitude entries for 3 days in a row',
      icon: '🔥',
      type: AchievementType.streak,
      rarity: AchievementRarity.common,
      targetValue: 3,
      xpReward: 25,
    ),
    Achievement(
      id: 'streak_7',
      title: 'Week Warrior',
      description: 'Write gratitude entries for 7 days in a row',
      icon: '⚡',
      type: AchievementType.streak,
      rarity: AchievementRarity.rare,
      targetValue: 7,
      xpReward: 50,
    ),
    Achievement(
      id: 'streak_30',
      title: 'Monthly Master',
      description: 'Write gratitude entries for 30 days in a row',
      icon: '🏆',
      type: AchievementType.streak,
      rarity: AchievementRarity.epic,
      targetValue: 30,
      xpReward: 150,
    ),
    Achievement(
      id: 'streak_100',
      title: 'Century Champion',
      description: 'Write gratitude entries for 100 days in a row',
      icon: '👑',
      type: AchievementType.streak,
      rarity: AchievementRarity.legendary,
      targetValue: 100,
      xpReward: 500,
    ),

    // Count achievements
    Achievement(
      id: 'count_10',
      title: 'Grateful Beginner',
      description: 'Write 10 gratitude entries',
      icon: '📝',
      type: AchievementType.count,
      rarity: AchievementRarity.common,
      targetValue: 10,
      xpReward: 20,
    ),
    Achievement(
      id: 'count_50',
      title: 'Gratitude Gatherer',
      description: 'Write 50 gratitude entries',
      icon: '📚',
      type: AchievementType.count,
      rarity: AchievementRarity.rare,
      targetValue: 50,
      xpReward: 75,
    ),
    Achievement(
      id: 'count_100',
      title: 'Hundred Hero',
      description: 'Write 100 gratitude entries',
      icon: '💯',
      type: AchievementType.count,
      rarity: AchievementRarity.epic,
      targetValue: 100,
      xpReward: 200,
    ),
    Achievement(
      id: 'count_500',
      title: 'Gratitude Guru',
      description: 'Write 500 gratitude entries',
      icon: '🎓',
      type: AchievementType.count,
      rarity: AchievementRarity.legendary,
      targetValue: 500,
      xpReward: 750,
    ),

    // Tag-specific achievements
    Achievement(
      id: 'health_10',
      title: 'Health Enthusiast',
      description: 'Write 10 gratitude entries about health',
      icon: '💚',
      type: AchievementType.tag,
      rarity: AchievementRarity.common,
      targetValue: 10,
      tag: 'health',
      xpReward: 30,
    ),
    Achievement(
      id: 'family_10',
      title: 'Family First',
      description: 'Write 10 gratitude entries about family',
      icon: '👨‍👩‍👧‍👦',
      type: AchievementType.tag,
      rarity: AchievementRarity.common,
      targetValue: 10,
      tag: 'family',
      xpReward: 30,
    ),
    Achievement(
      id: 'work_10',
      title: 'Work Warrior',
      description: 'Write 10 gratitude entries about work',
      icon: '💼',
      type: AchievementType.tag,
      rarity: AchievementRarity.common,
      targetValue: 10,
      tag: 'work',
      xpReward: 30,
    ),
    Achievement(
      id: 'nature_10',
      title: 'Nature Lover',
      description: 'Write 10 gratitude entries about nature',
      icon: '🌿',
      type: AchievementType.tag,
      rarity: AchievementRarity.common,
      targetValue: 10,
      tag: 'nature',
      xpReward: 30,
    ),

    // Special achievements
    Achievement(
      id: 'all_tags',
      title: 'Well Rounded',
      description: 'Write gratitude entries with all 5 tag types',
      icon: '🌈',
      type: AchievementType.special,
      rarity: AchievementRarity.rare,
      targetValue: 5,
      xpReward: 100,
    ),
    Achievement(
      id: 'long_entry',
      title: 'Deep Thinker',
      description: 'Write a gratitude entry with 100+ characters',
      icon: '📖',
      type: AchievementType.special,
      rarity: AchievementRarity.common,
      targetValue: 1,
      xpReward: 15,
    ),
    Achievement(
      id: 'early_bird',
      title: 'Early Bird',
      description: 'Write a gratitude entry before 8 AM',
      icon: '🌅',
      type: AchievementType.special,
      rarity: AchievementRarity.rare,
      targetValue: 1,
      xpReward: 40,
    ),
    Achievement(
      id: 'night_owl',
      title: 'Night Owl',
      description: 'Write a gratitude entry after 10 PM',
      icon: '🦉',
      type: AchievementType.special,
      rarity: AchievementRarity.rare,
      targetValue: 1,
      xpReward: 40,
    ),
  ];

  // Level names
  static const List<String> levelNames = [
    'Gratitude Seed',      // Level 1
    'Thankful Sprout',     // Level 2
    'Grateful Bud',        // Level 3
    'Appreciation Bloom',  // Level 4
    'Gratitude Flower',    // Level 5
    'Thankful Tree',       // Level 6
    'Grateful Forest',     // Level 7
    'Appreciation Garden', // Level 8
    'Gratitude Paradise',  // Level 9
    'Thankful Kingdom',    // Level 10
    'Grateful Empire',     // Level 11
    'Appreciation Realm',  // Level 12
    'Gratitude Universe',  // Level 13
    'Thankful Galaxy',     // Level 14
    'Grateful Cosmos',     // Level 15
    'Appreciation Master', // Level 16
    'Gratitude Sage',      // Level 17
    'Thankful Legend',     // Level 18
    'Grateful Myth',       // Level 19
    'Appreciation God',    // Level 20
  ];

  static String getLevelName(int level) {
    if (level <= 0 || level > levelNames.length) {
      return 'Unknown';
    }
    return levelNames[level - 1];
  }

  static int getXpForLevel(int level) {
    if (level <= 0 || level > levelXpRequirements.length) {
      return 0;
    }
    return levelXpRequirements[level - 1];
  }

  static int getXpToNextLevel(int currentLevel, int currentXp) {
    if (currentLevel >= levelXpRequirements.length) {
      return 0; // Max level reached
    }
    final nextLevelXp = getXpForLevel(currentLevel + 1);
    return nextLevelXp - currentXp;
  }

  static UserLevel calculateUserLevel(int totalXp) {
    int level = 1;
    for (int i = 0; i < levelXpRequirements.length; i++) {
      if (totalXp >= levelXpRequirements[i]) {
        level = i + 1;
      } else {
        break;
      }
    }

    final currentLevelXp = getXpForLevel(level);
    final xpToNextLevel = getXpToNextLevel(level, totalXp);

    return UserLevel(
      level: level,
      currentXp: totalXp - currentLevelXp,
      xpToNextLevel: xpToNextLevel,
      totalXp: totalXp,
    );
  }
}
