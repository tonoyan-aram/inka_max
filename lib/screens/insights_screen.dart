import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gratitude_entry.dart';
import '../services/gratitude_provider.dart';
import '../constants/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../widgets/insights_chart.dart';
import '../widgets/statistics_card.dart';
import 'add_entry_screen.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  String _selectedPeriod = 'month';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.gratitudeInsights),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'week',
                child: Row(
                  children: [
                    const Icon(Icons.calendar_view_week, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.thisWeek),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'month',
                child: Row(
                  children: [
                    const Icon(Icons.calendar_view_month, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.thisMonth),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'year',
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.thisYear),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'all',
                child: Row(
                  children: [
                    const Icon(Icons.all_inclusive, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.allTime),
                  ],
                ),
              ),
            ],
            child: const Icon(Icons.filter_list),
          ),
        ],
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

          if (provider.entries.isEmpty) {
            return _buildEmptyState();
          }

          final entries = _getFilteredEntries(provider.entries);
          final tagStats = _getTagStatistics(entries);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Period selector
                _buildPeriodSelector(),
                const SizedBox(height: 24),

                // Statistics cards
                _buildStatisticsCards(provider, entries),
                const SizedBox(height: 24),

                // Tag distribution chart
                if (tagStats.isNotEmpty) ...[
                  Text(
                    l10n.tagDistribution,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  InsightsChart(data: tagStats, chartType: ChartType.pie),
                  const SizedBox(height: 24),
                ],

                // Entries over time chart
                Text(
                  l10n.entriesOverTime,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                InsightsChart(
                  data: _getTimeSeriesData(entries),
                  chartType: ChartType.bar,
                ),
                const SizedBox(height: 24),

                // Streak information
                _buildStreakCard(provider.currentStreak),
                const SizedBox(height: 24),

                // Most used tags
                _buildMostUsedTags(tagStats),
                const SizedBox(height: 24),

                // Recent entries preview
                _buildRecentEntriesPreview(entries),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),
            Text(
              l10n.noInsightsYet,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add gratitude entries to see your patterns and progress over time.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddEntryScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addYourFirstEntry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final l10n = AppLocalizations.of(context);
    
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildPeriodButton('week', l10n.week),
          _buildPeriodButton('month', l10n.month),
          _buildPeriodButton('year', l10n.year),
          _buildPeriodButton('all', 'All'),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String value, String label) {
    final isSelected = _selectedPeriod == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPeriod = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? AppColors.onPrimary : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCards(
    GratitudeProvider provider,
    List<GratitudeEntry> entries,
  ) {
    return Row(
      children: [
        Expanded(
          child: StatisticsCard(
            title: 'Total Entries',
            value: entries.length.toString(),
            icon: Icons.article_outlined,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatisticsCard(
            title: 'Current Streak',
            value: '${provider.currentStreak} days',
            icon: Icons.local_fire_department,
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard(int streak) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.warning,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Current Streak',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '$streak days',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getStreakMessage(streak),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMostUsedTags(Map<GratitudeTag, int> tagStats) {
    if (tagStats.isEmpty) return const SizedBox.shrink();

    final sortedTags = tagStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most Used Tags',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...sortedTags.take(5).map((entry) {
              final tag = entry.key;
              final count = entry.value;
              final tagColor =
                  AppColors.tagColors[tag.name] ?? AppColors.primary;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(_getTagIcon(tag), color: tagColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(tag.displayName)),
                    Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: tagColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentEntriesPreview(List<GratitudeEntry> entries) {
    final recentEntries = entries.take(3).toList();
    if (recentEntries.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Entries',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...recentEntries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        entry.text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      _formatDate(entry.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  List<GratitudeEntry> _getFilteredEntries(List<GratitudeEntry> allEntries) {
    final now = DateTime.now();
    switch (_selectedPeriod) {
      case 'week':
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return allEntries.where((entry) {
          return entry.createdAt.isAfter(startOfWeek);
        }).toList();
      case 'month':
        final startOfMonth = DateTime(now.year, now.month, 1);
        return allEntries.where((entry) {
          return entry.createdAt.isAfter(startOfMonth);
        }).toList();
      case 'year':
        final startOfYear = DateTime(now.year, 1, 1);
        return allEntries.where((entry) {
          return entry.createdAt.isAfter(startOfYear);
        }).toList();
      case 'all':
      default:
        return allEntries;
    }
  }

  Map<GratitudeTag, int> _getTagStatistics(List<GratitudeEntry> entries) {
    Map<GratitudeTag, int> tagCounts = {};
    for (GratitudeTag tag in GratitudeTag.values) {
      tagCounts[tag] = 0;
    }

    for (var entry in entries) {
      for (GratitudeTag tag in entry.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }

    return tagCounts;
  }

  // Map<String, int> _getStreakData(List<GratitudeEntry> entries) {
  //   // Group entries by date
  //   Map<String, int> entriesByDate = {};
  //   for (var entry in entries) {
  //     final dateKey = DateTime(
  //       entry.createdAt.year,
  //       entry.createdAt.month,
  //       entry.createdAt.day,
  //     ).toIso8601String().split('T')[0];
  //     entriesByDate[dateKey] = (entriesByDate[dateKey] ?? 0) + 1;
  //   }
  //
  //   return entriesByDate;
  // }

  Map<String, double> _getTimeSeriesData(List<GratitudeEntry> entries) {
    Map<String, double> data = {};
    for (var entry in entries) {
      final dateKey = DateTime(
        entry.createdAt.year,
        entry.createdAt.month,
        entry.createdAt.day,
      ).toIso8601String().split('T')[0];
      data[dateKey] = (data[dateKey] ?? 0) + 1;
    }
    return data;
  }

  String _getStreakMessage(int streak) {
    if (streak == 0) {
      return 'Start your gratitude journey today!';
    } else if (streak < 7) {
      return 'Great start! Keep it up!';
    } else if (streak < 30) {
      return 'Amazing! You\'re building a great habit!';
    } else if (streak < 100) {
      return 'Incredible! You\'re a gratitude champion!';
    } else {
      return 'Legendary! You\'re a gratitude master!';
    }
  }

  IconData _getTagIcon(GratitudeTag tag) {
    switch (tag) {
      case GratitudeTag.health:
        return Icons.favorite;
      case GratitudeTag.family:
        return Icons.family_restroom;
      case GratitudeTag.work:
        return Icons.work;
      case GratitudeTag.nature:
        return Icons.nature;
      case GratitudeTag.other:
        return Icons.more_horiz;
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
      return '${date.month}/${date.day}';
    }
  }
}
