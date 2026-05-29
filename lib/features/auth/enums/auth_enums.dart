import 'package:flutter/material.dart';

enum UserRole {
  membro,
  intercambista;

  String get loginBadgeText => this == UserRole.membro
      ? 'Entrando como Membro da AIESEC'
      : 'Entrando como Intercambista';
  String get registerBadgeText => this == UserRole.membro
      ? 'Conta de Membro da AIESEC'
      : 'Conta de Intercambista';
  String get emailHint =>
      this == UserRole.membro ? 'seuemail@aiesec.org.br' : 'seu@email.com';
}

enum AuthView { selection, login, registerStep1, registerStep2, forgotPassword }

enum AiesecProgram {
  voluntarioGlobal('Voluntário Global', Color(0xFFF85A40)),
  talentoGlobal('Talento Global', Color(0xFF0CB9C1)),
  professorGlobal('Professor Global', Color(0xFFF48924));

  final String label;
  final Color productColor;
  const AiesecProgram(this.label, this.productColor);
}
