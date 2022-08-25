import 'package:cloud_firestore/cloud_firestore.dart';

class UserM {
  String id, email, name, tel, zipcode, adress, city, role;
  UserM({
    required this.id,
    required this.email,
    required this.name,
    required this.tel,
    required this.zipcode,
    required this.adress,
    required this.city,
    required this.role,
  });
  factory UserM.fromJson(Map<String, dynamic> j) => UserM(
      email: j['email'],
      id: j['id'],
      name: j['name'],
      tel: j['tel'],
      zipcode: j['zipcode'],
      adress: j['adress'],
      city: j['city'],
      role: j['role']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "name": name,
        "tel": tel,
        "adress": adress,
        "zipcode": zipcode,
        "city": city,
        "role": role,
      };
  factory UserM.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserM(
      name: data?['name'],
      id: data?['id'],
      email: data?['email'],
      tel: data?['tel'],
      adress: data?['adress'],
      zipcode: data?['zipcode'],
      city: data?['city'],
      role: data?['role'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (id != null) "id": id,
      if (tel != null) "tel": tel,
      if (zipcode != null) "zipcode": zipcode,
      if (email != null) "email": email,
      if (adress != null) "adress": adress,
      if (city != null) "city": city,
      if (role != null) "role": role,
    };
  }
}
