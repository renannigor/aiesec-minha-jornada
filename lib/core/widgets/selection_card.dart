import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.primaryBlue
        : AppColors.borderDefault;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: isSelected ? 2.0 : 1.0),
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.backgroundWhite,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryBlue.withValues(alpha: 0.1)
                    : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.heading2),
                  const SizedBox(height: 4),
                  Text(description, style: AppTextStyles.caption),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: borderColor,
            ),
          ],
        ),
      ),
    );
  }
}
