// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class Commande_en_coursM {
  String id, type, nom_client, tel;
  Commande_en_coursM({
    required this.id,
    required this.type,
    required this.nom_client,
    required this.tel,
  });
  factory Commande_en_coursM.fromJson(Map<String, dynamic> j) =>
      Commande_en_coursM(
          id: j['id'],
          nom_client: j['nom_client'],
          tel: j['tel'],
          type: j['type']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "nom_client": nom_client,
        "tel": tel,
      };
  factory Commande_en_coursM.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Commande_en_coursM(
      nom_client: data?['nom_client'],
      id: data?['id'],
      type: data?['type'],
      tel: data?['tel'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (nom_client != null) "name": nom_client,
      if (id != null) "id": id,
      if (tel != null) "tel": tel,
      if (type != null) "type": type,
    };
  }
}
