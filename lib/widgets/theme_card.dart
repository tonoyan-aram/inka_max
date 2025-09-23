import 'package:flutter/material.dart';
import '../models/app_theme.dart';

class ThemeCard extends StatelessWidget {
  final AppThemeData theme;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeCard({
    super.key,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 6 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: theme.gradients.background,
            border: isSelected
                ? Border.all(
                    color: theme.colors.primary,
                    width: 3,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    // Theme icon
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: theme.gradients.primary,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          theme.icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Theme info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                theme.name,
                                style: TextStyle(
                                  color: theme.colors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (theme.isPremium)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'PREMIUM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            theme.description,
                            style: TextStyle(
                              color: theme.colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Selection indicator
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: theme.colors.primary,
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Color preview
                Row(
                  children: [
                    _buildColorPreview('Primary', theme.colors.primary),
                    const SizedBox(width: 8),
                    _buildColorPreview('Secondary', theme.colors.secondary),
                    const SizedBox(width: 8),
                    _buildColorPreview('Surface', theme.colors.surface),
                    const SizedBox(width: 8),
                    _buildColorPreview('Background', theme.colors.background),
                  ],
                ),
                const SizedBox(height: 12),

                // Theme type and seasonal info
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colors.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        _getThemeTypeName(theme.type),
                        style: TextStyle(
                          color: theme.colors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (theme.seasonalType != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colors.secondary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          _getSeasonalTypeName(theme.seasonalType!),
                          style: TextStyle(
                            color: theme.colors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPreview(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colors.border,
              width: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: theme.colors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  String _getThemeTypeName(ThemeType type) {
    switch (type) {
      case ThemeType.light:
        return 'Light';
      case ThemeType.dark:
        return 'Dark';
      case ThemeType.seasonal:
        return 'Seasonal';
      case ThemeType.custom:
        return 'Custom';
    }
  }

  String _getSeasonalTypeName(SeasonalTheme seasonalType) {
    switch (seasonalType) {
      case SeasonalTheme.spring:
        return 'Spring';
      case SeasonalTheme.summer:
        return 'Summer';
      case SeasonalTheme.autumn:
        return 'Autumn';
      case SeasonalTheme.winter:
        return 'Winter';
    }
  }
}
