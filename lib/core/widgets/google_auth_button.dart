import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_assets.dart';

class GoogleAuthButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleAuthButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.borderDefault),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        icon: Image.asset(AppAssets.logoGoogle, height: 24),
        label: Text(
          'Google',
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
