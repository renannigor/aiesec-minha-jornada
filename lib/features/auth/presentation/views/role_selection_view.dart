import 'package:flutter/material.dart';

// Componentes Core

import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/selection_card.dart';

// Enums e Widgets específicos da feature de Autenticação
import '../../enums/auth_enums.dart';
import '../widgets/auth_header.dart';

class RoleSelectionView extends StatelessWidget {
  // 1. Variáveis recebidas do Controlador (AuthControllerPage)
  final UserRole currentRole;
  final ValueChanged<UserRole> onRoleChanged;
  final VoidCallback onContinue;

  const RoleSelectionView({
    super.key,
    required this.currentRole,
    required this.onRoleChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho Padrão com Logótipo e Títulos
        const AuthHeader(
          title: 'Quem é você na jornada?',
          subtitle: 'Selecione uma opção para continuar.',
        ),

        const SizedBox(height: 40),

        // Cartão: Membro da AIESEC
        SelectionCard(
          title: 'Membro da AIESEC',
          description:
              'Você faz parte da organização e quer acompanhar experiências.',
          icon: Icons.people_outline,
          // Compara se o Enum atual é Membro
          isSelected: currentRole == UserRole.membro,
          // Se clicado, avisa o controlador para mudar o estado para Membro
          onTap: () => onRoleChanged(UserRole.membro),
        ),

        const SizedBox(height: 16),

        // Cartão: Intercambista
        SelectionCard(
          title: 'Intercambista',
          description:
              'Você está se preparando para viver seu intercâmbio com a AIESEC.',
          icon: Icons.flight_takeoff_outlined,
          // Compara se o Enum atual é Intercambista
          isSelected: currentRole == UserRole.intercambista,
          // Se clicado, avisa o controlador para mudar o estado para Intercambista
          onTap: () => onRoleChanged(UserRole.intercambista),
        ),

        const SizedBox(height: 40),

        // Botão de Avançar (Que despoleta a mudança de View para o ecrã de Login)
        PrimaryButton(
          text: 'Continuar',
          icon: Icons.arrow_forward,
          onPressed: onContinue,
        ),
      ],
    );
  }
}
