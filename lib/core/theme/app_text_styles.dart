import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String fontFamily = 'Inter';

  // --- TÍTULOS ---
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36, // Aumentado (era 32)
    fontWeight: FontWeight.w900, 
    color: AppColors.textPrimary,
    height: 1.2, // Ajuda no respiro entre linhas grandes
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20, // Aumentado (era 16)
    fontWeight: FontWeight.w700, 
    color: AppColors.textPrimary,
  );

  // --- CORPOS DE TEXTO ---
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18, // Aumentado (era 16)
    fontWeight: FontWeight.w400, 
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15, // Aumentado (era 13)
    fontWeight: FontWeight.w400, 
    color: AppColors.textSecondary,
    height: 1.4, // Melhora a leitura da descrição no card
  );

  // --- BOTÕES E LINKS ---
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18, // Aumentado (era 16)
    fontWeight: FontWeight.w700, 
    color: AppColors.backgroundWhite,
  );
  
  static const TextStyle linkText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18, // Aumentado (era 14)
    fontWeight: FontWeight.w700, 
    color: AppColors.primaryBlue,
  );
}