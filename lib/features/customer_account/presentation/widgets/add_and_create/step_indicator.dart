import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.navy : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}