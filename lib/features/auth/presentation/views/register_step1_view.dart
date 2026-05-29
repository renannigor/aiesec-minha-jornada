import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/widgets/back_navigation_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../enums/auth_enums.dart';
import '../widgets/role_badge.dart';
import '../widgets/step_progress_bar.dart';

class RegisterStep1View extends StatefulWidget {
  final UserRole role;
  final VoidCallback onBack;
  final VoidCallback onContinue;
  final VoidCallback onNavigateToLogin;

  const RegisterStep1View({
    super.key,
    required this.role,
    required this.onBack,
    required this.onContinue,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterStep1View> createState() => _RegisterStep1ViewState();
}

class _RegisterStep1ViewState extends State<RegisterStep1View> {
  final _formKey = GlobalKey<FormState>(); // <-- Chave do formulário do Passo 1

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
            text: widget.role.registerBadgeText,
            icon: Icons.person_add_alt_1_outlined,
          ),
          const SizedBox(height: 16),
          const Text('Criar conta', style: AppTextStyles.heading1),
          const SizedBox(height: 8),
          Text(
            'Passo 1 de 2 — seus dados',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          const StepProgressBar(currentStep: 1),
          const SizedBox(height: 32),

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nome', style: AppTextStyles.heading2),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'seu nome',
                            prefixIcon: Icons.person_outline,
                            validator: (value) => FormValidators.notEmpty(
                              value,
                              fieldName: 'nome',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sobrenome',
                            style: AppTextStyles.heading2,
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'seu sobrenome',
                            validator: (value) => FormValidators.notEmpty(
                              value,
                              fieldName: 'sobrenome',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nome', style: AppTextStyles.heading2),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'seu nome',
                      prefixIcon: Icons.person_outline,
                      validator: (value) =>
                          FormValidators.notEmpty(value, fieldName: 'nome'),
                    ),
                    const SizedBox(height: 24),
                    const Text('Sobrenome', style: AppTextStyles.heading2),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'seu sobrenome',
                      validator: (value) => FormValidators.notEmpty(
                        value,
                        fieldName: 'sobrenome',
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 24),
          const Text('E-mail', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: widget.role.emailHint,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: FormValidators.email,
          ),
          const SizedBox(height: 24),
          const Text('Telefone', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: '(81) 99999-9999',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            mask: '(##) #####-####',
            validator: (value) =>
                FormValidators.notEmpty(value, fieldName: 'telefone'),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'Continuar',
            onPressed: () {
              // Só avança para a View 2 se todos os campos passarem na validação
              if (_formKey.currentState!.validate()) {
                widget.onContinue();
              }
            },
          ),
          const SizedBox(height: 32),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Já tem uma conta? ',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: widget.onNavigateToLogin,
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text(
                    'Fazer login',
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
