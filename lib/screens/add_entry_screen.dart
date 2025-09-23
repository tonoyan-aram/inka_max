import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/gratitude_entry.dart';
import '../services/gratitude_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../widgets/tag_selector.dart';
import '../widgets/confetti_widget.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<GratitudeTag> _selectedTags = [];
  bool _isLoading = false;
  late ConfettiController _confettiController;
  late AnimationController _eggAnimationController;
  late Animation<double> _eggAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _eggAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _eggAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _eggAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _textController.dispose();
    _confettiController.dispose();
    _eggAnimationController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    if (_textController.text.trim().isEmpty) {
      _showSnackBar('Please enter your gratitude text', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final provider = Provider.of<GratitudeProvider>(context, listen: false);
    final success = await provider.addEntry(_textController.text.trim(), _selectedTags);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Show confetti animation if enabled
      if (provider.animationsEnabled) {
        _confettiController.play();
        _eggAnimationController.forward();
        
        // Reset animation after completion
        Future.delayed(const Duration(seconds: 2), () {
          _eggAnimationController.reset();
        });
      }

      _showSnackBar('Gratitude added to your nest! 🥚', isError: false);
      
      // Clear form
      _textController.clear();
      setState(() {
        _selectedTags.clear();
      });

      // Navigate back after a short delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      _showSnackBar('Failed to save entry. Please try again.', isError: true);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add New Entry'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveEntry,
            child: Text(
              'Save',
              style: TextStyle(
                color: _isLoading ? AppColors.textDisabled : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'What are you grateful for today?',
                  style: Theme.of(context).textTheme.headlineMedium,
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

                // Gratitude text input
                Text(
                  'Write your gratitude:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _textController,
                  maxLines: 6,
                  maxLength: AppConstants.maxGratitudeTextLength,
                  decoration: const InputDecoration(
                    hintText: 'Start typing what you\'re grateful for...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Tags section
                Text(
                  'Add tags (optional):',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TagSelector(
                  selectedTags: _selectedTags,
                  onTagsChanged: (tags) {
                    setState(() {
                      _selectedTags.clear();
                      _selectedTags.addAll(tags);
                    });
                  },
                ),
                const SizedBox(height: 32),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: AppConstants.buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _saveEntry,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.onPrimary),
                            ),
                          )
                        : const Icon(Icons.add_circle_outline),
                    label: Text(_isLoading ? 'Saving...' : 'Add Egg'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Instruction text
                Text(
                  'Express gratitude for something in your life today, big or small.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // Confetti animation
          if (Provider.of<GratitudeProvider>(context).animationsEnabled)
            CustomConfettiWidget(controller: _confettiController),

          // Egg animation
          if (Provider.of<GratitudeProvider>(context).animationsEnabled)
            AnimatedBuilder(
              animation: _eggAnimation,
              builder: (context, child) {
                return Positioned(
                  bottom: 100,
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  child: Transform.scale(
                    scale: _eggAnimation.value,
                    child: Opacity(
                      opacity: _eggAnimation.value.clamp(0.0, 1.0),
                      child: const Icon(
                        Icons.egg,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }
}
