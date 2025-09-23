import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../services/gratitude_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<GratitudeProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Visuals section
              _buildSectionHeader('Visuals'),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.celebration, color: AppColors.primary),
                  title: const Text('Show confetti on save'),
                  subtitle: const Text('Enable celebration animations when saving entries'),
                  trailing: Switch(
                    value: provider.animationsEnabled,
                    onChanged: (value) {
                      provider.toggleAnimations();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Data Management section
              _buildSectionHeader('Data Management'),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.upload, color: AppColors.info),
                      title: const Text('Export My Entries'),
                      subtitle: const Text('Download your gratitude entries as JSON file'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _exportEntries(context, provider),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.delete_forever, color: AppColors.error),
                      title: const Text('Reset All Data'),
                      subtitle: const Text('Permanently delete all your gratitude entries'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showResetDialog(context, provider),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // App Info section
              _buildSectionHeader('App Info'),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info, color: AppColors.primary),
                      title: const Text('Version'),
                      subtitle: Text(AppConstants.appVersion),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.description, color: AppColors.primary),
                      title: const Text('About'),
                      subtitle: const Text('Inka Max - Cultivate gratitude, one cluck at a time'),
                      onTap: () => _showAboutDialog(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Statistics section
              _buildSectionHeader('Your Statistics'),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.article, color: AppColors.success),
                      title: const Text('Total Entries'),
                      subtitle: Text('${provider.totalEntries} gratitude entries'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.local_fire_department, color: AppColors.warning),
                      title: const Text('Current Streak'),
                      subtitle: Text('${provider.currentStreak} days in a row'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.calendar_today, color: AppColors.info),
                      title: const Text('Days with Entries'),
                      subtitle: Text('${provider.getTotalDaysWithEntries()} days'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // App motto
              Center(
                child: Text(
                  AppConstants.appMotto,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Future<void> _exportEntries(BuildContext context, GratitudeProvider provider) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Exporting entries...'),
            ],
          ),
        ),
      );

      // Export data
      final jsonData = await provider.exportEntries();
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${AppConstants.exportFileName}_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = File('${directory.path}/$fileName');
      
      await file.writeAsString(jsonData);

      // Close loading dialog
      Navigator.of(context).pop();

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Export Successful'),
          content: Text('Your gratitude entries have been exported to:\n${file.path}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Export Failed'),
          content: Text('Failed to export entries: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _showResetDialog(BuildContext context, GratitudeProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Data'),
        content: const Text(
          'Are you sure you want to permanently delete all your gratitude entries? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _resetAllData(context, provider);
            },
            child: const Text(
              'Reset',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _resetAllData(BuildContext context, GratitudeProvider provider) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Resetting data...'),
            ],
          ),
        ),
      );

      // Reset data
      await provider.deleteAllEntries();

      // Close loading dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All data has been reset successfully'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reset data: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showAboutDialog(BuildContext context) {
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
        const SizedBox(height: 16),
        const Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• Daily gratitude entries with tags'),
        const Text('• Beautiful animations and celebrations'),
        const Text('• Insights and analytics'),
        const Text('• Export and backup your data'),
        const Text('• Streak tracking'),
      ],
    );
  }
}
