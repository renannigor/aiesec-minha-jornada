import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_assets.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logoAiesec, height: 44, fit: BoxFit.contain),
            const SizedBox(width: 12),
            // O Flexible garante que o texto quebre a linha se faltar espaço
            Flexible(
              child: Text(
                'AIESEC no Brasil',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.primaryBlue,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(title, style: AppTextStyles.heading1),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
