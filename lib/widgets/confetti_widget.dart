import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../constants/app_colors.dart';

class CustomConfettiWidget extends StatelessWidget {
  final ConfettiController controller;

  const CustomConfettiWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: controller,
        blastDirection: 1.57, // Downward
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [
          AppColors.primary,
          AppColors.secondary,
          AppColors.success,
          AppColors.warning,
          AppColors.info,
        ],
        emissionFrequency: 0.05,
        numberOfParticles: 50,
        gravity: 0.3,
        maxBlastForce: 20,
        minBlastForce: 5,
      ),
    );
  }
}
