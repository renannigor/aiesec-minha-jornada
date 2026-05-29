import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/form_validators.dart'; 
import '../../../../core/widgets/back_navigation_button.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/google_auth_button.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../enums/auth_enums.dart';
import '../widgets/role_badge.dart';

class LoginView extends StatefulWidget {
  final UserRole role;
  final VoidCallback onBack;
  final VoidCallback onNavigateToRegister;
  final VoidCallback onNavigateToForgotPassword; 

  const LoginView({
    super.key,
    required this.role,
    required this.onBack,
    required this.onNavigateToRegister,
    required this.onNavigateToForgotPassword,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>(); 
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackNavigationButton(onPressed: widget.onBack),
          const SizedBox(height: 24),
          RoleBadge(
            text: widget.role.loginBadgeText,
            icon: widget.role == UserRole.membro
                ? Icons.badge_outlined
                : Icons.person_outline,
          ),
          const SizedBox(height: 16),
          const Text('Bem-vindo de volta', style: AppTextStyles.heading1),
          const SizedBox(height: 8),
          Text(
            'Entre para continuar sua jornada.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          const Text('E-mail', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: widget.role.emailHint,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: FormValidators.email, 
          ),
          const SizedBox(height: 24),
          const Text('Senha', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: FormValidators.password, 
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomCheckbox(
                  value: _rememberMe,
                  onChanged: (val) =>
                      setState(() => _rememberMe = val ?? false),
                  label: Text(
                    'Lembrar de mim',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: widget
                    .onNavigateToForgotPassword, 
                child: const Text(
                  'Esqueci a senha',
                  style: AppTextStyles.linkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            text: 'Entrar',
            onPressed: () {
              // Dispara a validação de todos os campos do formulário
              if (_formKey.currentState!.validate()) {
                print('Tudo certo! Logando...');
              }
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: Divider(color: AppColors.borderDefault)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('OU CONTINUE COM', style: AppTextStyles.caption),
              ),
              Expanded(child: Divider(color: AppColors.borderDefault)),
            ],
          ),
          const SizedBox(height: 24),
          GoogleAuthButton(onPressed: () {}),
          const SizedBox(height: 32),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Ainda não tem cadastro? ',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: widget.onNavigateToRegister,
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text(
                    'Criar conta',
                    style: AppTextStyles.linkText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
