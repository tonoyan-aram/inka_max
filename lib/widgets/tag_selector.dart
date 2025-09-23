import 'package:flutter/material.dart';
import '../models/gratitude_entry.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class TagSelector extends StatelessWidget {
  final List<GratitudeTag> selectedTags;
  final Function(List<GratitudeTag>) onTagsChanged;

  const TagSelector({
    super.key,
    required this.selectedTags,
    required this.onTagsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: GratitudeTag.values.map((tag) {
        final isSelected = selectedTags.contains(tag);
        final tagColor = AppColors.tagColors[tag.name] ?? AppColors.primary;
        
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              // Remove tag
              final newTags = List<GratitudeTag>.from(selectedTags);
              newTags.remove(tag);
              onTagsChanged(newTags);
            } else if (selectedTags.length < AppConstants.maxTagsPerEntry) {
              // Add tag
              final newTags = List<GratitudeTag>.from(selectedTags);
              newTags.add(tag);
              onTagsChanged(newTags);
            } else {
              // Show message about max tags
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You can select up to ${AppConstants.maxTagsPerEntry} tags'),
                  backgroundColor: AppColors.warning,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
              );
            }
          },
          child: AnimatedContainer(
            duration: AppConstants.shortAnimation,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? tagColor : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? tagColor : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: tagColor.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  Icon(
                    Icons.check,
                    size: 16,
                    color: AppColors.onPrimary,
                  )
                else
                  Icon(
                    _getTagIcon(tag),
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                const SizedBox(width: 6),
                Text(
                  tag.displayName,
                  style: TextStyle(
                    color: isSelected ? AppColors.onPrimary : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
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
}
