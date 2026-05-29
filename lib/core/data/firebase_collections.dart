import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comite_model.dart'; 

class FirebaseCollections {
  FirebaseCollections._(); // Construtor privado para evitar instanciação

  static final _db = FirebaseFirestore.instance;

  // --- Referências das Coleções ---

  /// Referência tipada para a coleção 'comites', convertida para o model [ComiteModel].
  /// Usa o 'nome_podio' como o ID natural do documento.
  static final CollectionReference<ComiteModel> comites = _db
      .collection('comites')
      .withConverter<ComiteModel>(
        fromFirestore: (snapshot, _) => ComiteModel.fromJson(snapshot.data()!),
        toFirestore: (comite, _) => comite.toJson(),
      );
}
