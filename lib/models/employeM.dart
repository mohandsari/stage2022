import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeM {
  String id, name, tel, role;
  double lat, long;
  EmployeM({
    required this.id,
    required this.name,
    required this.tel,
    required this.lat,
    required this.long,
    required this.role,
  });
  String get getid {
    return id;
  }

  factory EmployeM.fromJson(Map<String, dynamic> j) => EmployeM(
      lat: j['lat'],
      id: j['id'],
      name: j['name'],
      tel: j['tel'],
      long: j['long'],
      role: j['role']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "lat": lat,
        "name": name,
        "tel": tel,
        "long": long,
        "role": role,
      };
  factory EmployeM.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EmployeM(
      name: data?['name'],
      id: data?['id'],
      lat: data?['lat'],
      tel: data?['tel'],
      long: data?['long'],
      role: data?['role'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (id != null) "id": id,
      if (tel != null) "tel": tel,
      if (lat != null) "lat": lat,
      if (long != null) "long": long,
      if (role != null) "role": role,
    };
  }
}
