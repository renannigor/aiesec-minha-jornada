import 'package:cloud_firestore/cloud_firestore.dart';

class ComiteModel {
  final String nome;
  final String nomePodio;
  final String cidade;
  final String estado;
  final String status;

  ComiteModel({
    required this.nome,
    required this.nomePodio,
    required this.cidade,
    required this.estado,
    required this.status,
  });

  /// Verifica se o comitê está ativo na organização
  bool get isAtivo => status.toLowerCase() == 'ativo';

  /// Converte um JSON/Map vindo do Firestore em uma instância de [ComiteModel]
  factory ComiteModel.fromJson(Map<String, dynamic> json) {
    return ComiteModel(
      nome: json['nome'] as String? ?? '',
      nomePodio: json['nome_podio'] as String? ?? '',
      cidade: json['cidade'] as String? ?? '',
      estado: json['estado'] as String? ?? '',
      status: json['status'] as String? ?? 'inativo',
    );
  }

  /// Cria uma instância a partir de um [DocumentSnapshot] do Firestore
  factory ComiteModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return ComiteModel.fromJson(snapshot.data() ?? {});
  }

  /// Converte a instância atual em um Map pronto para ser salvo no Firestore
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'nome_podio': nomePodio,
      'cidade': cidade,
      'estado': estado,
      'status': status,
    };
  }
}
