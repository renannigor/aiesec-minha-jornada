import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/data/firebase_collections.dart';
import '../../../../core/models/comite_model.dart';

class ComiteService {
  /// Recupera todos os comitês cadastrados no banco de dados (ativos e inativos)
  Future<List<ComiteModel>> buscarTodosComites() async {
    try {
      final querySnapshot = await FirebaseCollections.comites.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Erro ao buscar todos os comitês: $e');
      return [];
    }
  }

  /// Filtra e retorna apenas os escritórios que estão com o status "ativo"
  /// Ideal para popular o Dropdown da tela de cadastro de membros
  Future<List<ComiteModel>> buscarComitesAtivos() async {
    try {
      final querySnapshot = await FirebaseCollections.comites
          .where('status', isEqualTo: 'ativo')
          .orderBy('nome') // Ordena alfabeticamente pelo nome do comitê
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Erro ao buscar comitês ativos: $e');
      return [];
    }
  }

  /// Busca um comitê específico usando seu ID único (nome_podio)
  Future<ComiteModel?> buscarComitePorId(String nomePodio) async {
    try {
      final docSnapshot = await FirebaseCollections.comites
          .doc(nomePodio)
          .get();
      return docSnapshot.data();
    } catch (e) {
      print('Erro ao buscar o comitê $nomePodio: $e');
      return null;
    }
  }

  /// Salva ou atualiza um comitê de forma tipada utilizando o WriteBatch
  Future<void> salvarListaComites(List<ComiteModel> lista) async {
    final batch = FirebaseFirestore.instance.batch();

    for (var comite in lista) {
      final docRef = FirebaseCollections.comites.doc(comite.nomePodio);
      batch.set(
        docRef,
        comite,
      ); // O conversor transforma o model em JSON nos bastidores
    }

    await batch.commit();
  }
}
