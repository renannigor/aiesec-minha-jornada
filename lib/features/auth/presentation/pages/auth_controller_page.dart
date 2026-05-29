import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/responsive.dart';
import '../../enums/auth_enums.dart';

// Importe as suas views aqui
import '../views/role_selection_view.dart';
import '../views/login_view.dart';
import '../views/register_step1_view.dart';
import '../views/register_step2_view.dart';
import '../views/forgot_password_view.dart';

class AuthControllerPage extends StatefulWidget {
  const AuthControllerPage({super.key});

  @override
  State<AuthControllerPage> createState() => _AuthControllerPageState();
}

class _AuthControllerPageState extends State<AuthControllerPage> {
  // 1. Variáveis de Estado (Iniciamos na tela de seleção)
  AuthView _currentView = AuthView.selection;
  UserRole _selectedRole = UserRole.membro; // Valor padrão inicial

  // 2. Funções de controle de fluxo
  void _changeView(AuthView view) {
    setState(() => _currentView = view);
  }

  void _changeRole(UserRole role) {
    setState(() => _selectedRole = role);
  }

  // 3. Renderizador Dinâmico
  Widget _buildCurrentView() {
    switch (_currentView) {
      case AuthView.selection:
        return RoleSelectionView(
          currentRole: _selectedRole,
          onRoleChanged: _changeRole,
          onContinue: () => _changeView(AuthView.login),
        );
      case AuthView.login:
        return LoginView(
          role: _selectedRole,
          onBack: () => _changeView(AuthView.selection),
          onNavigateToRegister: () => _changeView(AuthView.registerStep1),
          onNavigateToForgotPassword: () =>
              _changeView(AuthView.forgotPassword),
        );
      case AuthView.forgotPassword:
        return ForgotPasswordView(onBack: () => _changeView(AuthView.login));
      case AuthView.registerStep1:
        return RegisterStep1View(
          role: _selectedRole,
          onBack: () => _changeView(AuthView.login),
          onContinue: () => _changeView(AuthView.registerStep2),
          onNavigateToLogin: () => _changeView(AuthView.login),
        );
      case AuthView.registerStep2:
        return RegisterStep2View(
          role: _selectedRole,
          onBack: () => _changeView(AuthView.registerStep1),
          onNavigateToLogin: () => _changeView(AuthView.login),
        );
    }
  }

  // 4. Estrutura Base
  Widget _buildResponsiveContainer(double maxWidth) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: _buildCurrentView(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Responsive(
        mobile: _buildResponsiveContainer(double.infinity),
        tablet: _buildResponsiveContainer(600),
        desktop: _buildResponsiveContainer(650),
      ),
    );
  }
}
