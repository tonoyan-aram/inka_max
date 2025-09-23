import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/gratitude_entry.dart';
import '../services/gratitude_provider.dart';
import '../constants/app_colors.dart';
import '../widgets/gratitude_entry_card.dart';
import '../widgets/empty_nest_widget.dart';
import 'add_entry_screen.dart';

class NestScreen extends StatefulWidget {
  const NestScreen({super.key});

  @override
  State<NestScreen> createState() => _NestScreenState();
}

class _NestScreenState extends State<NestScreen> {
  String _selectedFilter = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<GratitudeEntry> _getFilteredEntries() {
    final provider = Provider.of<GratitudeProvider>(context);
    List<GratitudeEntry> entries = provider.entries;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      entries = entries.where((entry) {
        return entry.text.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by tag
    if (_selectedFilter != 'all') {
      final tag = GratitudeTag.values.firstWhere(
        (tag) => tag.name == _selectedFilter,
        orElse: () => GratitudeTag.other,
      );
      entries = entries.where((entry) {
        return entry.tags.contains(tag);
      }).toList();
    }

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Your Gratitude Nest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: GratitudeSearchDelegate());
            },
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

          final entries = _getFilteredEntries();

          if (entries.isEmpty) {
            return EmptyNestWidget(
              hasEntries: provider.entries.isNotEmpty,
              searchQuery: _searchQuery,
              selectedFilter: _selectedFilter,
            );
          }

          return Column(
            children: [
              // Filter chips
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterChip('all', 'All', Icons.all_inclusive),
                    const SizedBox(width: 8),
                    ...GratitudeTag.values.map(
                      (tag) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildFilterChip(
                          tag.name,
                          tag.displayName,
                          _getTagIcon(tag),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search your gratitude entries...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),

              // Entries list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return GratitudeEntryCard(
                      entry: entry,
                      onTap: () => _showEntryDetails(entry),
                      onEdit: () => _editEntry(entry),
                      onDelete: () => _deleteEntry(entry),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "nest_fab",
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddEntryScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label, IconData icon) {
    final isSelected = _selectedFilter == value;

    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? value : 'all';
        });
      },
      selectedColor: AppColors.primary,
      checkmarkColor: AppColors.onPrimary,
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

  void _showEntryDetails(GratitudeEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(DateFormat('MMM dd, yyyy').format(entry.createdAt)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.text),
            if (entry.tags.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Tags:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: entry.tags.map((tag) {
                  final tagColor =
                      AppColors.tagColors[tag.name] ?? AppColors.primary;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tagColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: tagColor.withOpacity(0.3)),
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
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _editEntry(GratitudeEntry entry) {
    // TODO: Implement edit functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit functionality coming soon!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _deleteEntry(GratitudeEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text(
          'Are you sure you want to delete this gratitude entry?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final provider = Provider.of<GratitudeProvider>(
                context,
                listen: false,
              );
              await provider.deleteEntry(entry.id);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class GratitudeSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context, query);
  }

  Widget _buildSearchResults(BuildContext context, String searchQuery) {
    return Consumer<GratitudeProvider>(
      builder: (context, provider, child) {
        final entries = provider.entries.where((entry) {
          return entry.text.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

        if (entries.isEmpty) {
          return const Center(child: Text('No entries found'));
        }

        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return GratitudeEntryCard(
              entry: entry,
              onTap: () {
                close(context, null);
                // Show entry details
              },
            );
          },
        );
      },
    );
  }
}
