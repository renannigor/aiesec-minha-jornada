import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/widgets/back_navigation_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class ForgotPasswordView extends StatefulWidget {
  final VoidCallback onBack;

  const ForgotPasswordView({super.key, required this.onBack});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackNavigationButton(onPressed: widget.onBack),
          const SizedBox(height: 32),
          const Text('Recuperar senha', style: AppTextStyles.heading1),
          const SizedBox(height: 8),
          Text(
            'Informe seu e-mail cadastrado e enviaremos um link para você redefinir sua senha.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          const Text('E-mail', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: 'seu@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: FormValidators.email, 
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'Enviar link de recuperação',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Lógica de envio de e-mail do Firebase aqui
                print('E-mail válido! Enviando link...');
              }
            },
          ),
        ],
      ),
    );
  }
}
