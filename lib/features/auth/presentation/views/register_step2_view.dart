import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/widgets/back_navigation_button.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../enums/auth_enums.dart';
import '../widgets/role_badge.dart';
import '../widgets/step_progress_bar.dart';

// Importe o seu serviço aqui (ajuste o caminho conforme a sua estrutura)
import '../../data/services/comite_service.dart';

class RegisterStep2View extends StatefulWidget {
  final UserRole role;
  final VoidCallback onBack;
  final VoidCallback onNavigateToLogin;

  const RegisterStep2View({
    super.key,
    required this.role,
    required this.onBack,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterStep2View> createState() => _RegisterStep2ViewState();
}

class _RegisterStep2ViewState extends State<RegisterStep2View> {
  final _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;
  String? _selectedDropdownValue;

  // 1. Variáveis para o carregamento dinâmico
  final ComiteService _comiteService = ComiteService();
  List<String> _comitesLocais = [];
  bool _isLoadingComites = false;

  @override
  void initState() {
    super.initState();
    // 2. Dispara a busca apenas se o usuário for membro
    if (widget.role == UserRole.membro) {
      _carregarComites();
    }
  }

  // 3. Função assíncrona que busca os dados no Firestore
  Future<void> _carregarComites() async {
    setState(() {
      _isLoadingComites = true;
    });

    final comites = await _comiteService.buscarComitesAtivos();

    // Se a tela ainda estiver montada após o await, atualiza o estado
    if (mounted) {
      setState(() {
        // Mapeia a lista de ComiteModel apenas para os nomes (Strings)
        _comitesLocais = comites.map((c) => c.nome).toList();
        _isLoadingComites = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> programasAiesec = AiesecProgram.values
        .map((e) => e.label)
        .toList();
    final String dropdownFieldName = widget.role == UserRole.membro
        ? 'comitê local'
        : 'programa';

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
            'Passo 2 de 2 — segurança e perfil',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          const StepProgressBar(currentStep: 2),
          const SizedBox(height: 32),
          const Text('Senha', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: 'Crie uma senha',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: FormValidators.password,
          ),
          const SizedBox(height: 24),

          Text(
            widget.role == UserRole.membro
                ? 'Comitê local'
                : 'Programa da AIESEC',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 8),

          // 4. Dropdown atualizado com estado de carregamento
          CustomDropdown(
            hintText: widget.role == UserRole.membro
                ? (_isLoadingComites
                      ? 'Carregando comitês...'
                      : 'Selecione seu CL')
                : 'Selecione seu tipo de intercâmbio',
            items: widget.role == UserRole.membro
                ? _comitesLocais
                : programasAiesec,
            value: _selectedDropdownValue,
            validator: (value) =>
                FormValidators.selection(value, fieldName: dropdownFieldName),
            onChanged: _isLoadingComites
                ? null
                : (value) {
                    setState(() {
                      _selectedDropdownValue = value;
                    });
                  },
          ),
          const SizedBox(height: 32),
          CustomCheckbox(
            value: _acceptTerms,
            onChanged: (val) => setState(() => _acceptTerms = val ?? false),
            label: RichText(
              text: TextSpan(
                text: 'Concordo com os ',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                children: const [
                  TextSpan(
                    text: 'Termos de uso',
                    style: AppTextStyles.linkText,
                  ),
                  TextSpan(text: ' e a '),
                  TextSpan(
                    text: 'Política de privacidade',
                    style: AppTextStyles.linkText,
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'Criar conta',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (!_acceptTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Você precisa aceitar os Termos de uso e a Política de privacidade para continuar.',
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }

                print('Tudo validado! Cadastrando no Firebase...');
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
