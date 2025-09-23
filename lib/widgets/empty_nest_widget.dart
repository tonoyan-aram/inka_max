import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class EmptyNestWidget extends StatelessWidget {
  final bool hasEntries;
  final String searchQuery;
  final String selectedFilter;

  const EmptyNestWidget({
    super.key,
    required this.hasEntries,
    this.searchQuery = '',
    this.selectedFilter = 'all',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // House icon
            Icon(Icons.home_outlined, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),

            // Title
            Text(
              _getTitle(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              _getDescription(),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Action button
            if (!hasEntries || (searchQuery.isEmpty && selectedFilter == 'all'))
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/add_entry');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Your First Entry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Clear filters
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Filters'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    if (!hasEntries) {
      return 'Your nest is empty';
    } else if (searchQuery.isNotEmpty) {
      return 'No entries found';
    } else if (selectedFilter != 'all') {
      return 'No entries with this tag';
    } else {
      return 'No entries found';
    }
  }

  String _getDescription() {
    if (!hasEntries) {
      return 'Add your first gratitude entry to start filling your nest with positivity.';
    } else if (searchQuery.isNotEmpty) {
      return 'Try searching with different keywords or clear the search to see all entries.';
    } else if (selectedFilter != 'all') {
      return 'No gratitude entries found with the selected tag. Try selecting a different tag or add new entries.';
    } else {
      return 'No gratitude entries found. Add some entries to get started.';
    }
  }
}
