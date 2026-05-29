import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;

  const StepProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: currentStep >= 2
                  ? AppColors.primaryBlue
                  : AppColors.borderDefault,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
