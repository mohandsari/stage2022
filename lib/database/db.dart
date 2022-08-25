import 'package:auth/models/employeM.dart';
import 'package:auth/models/userM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBservices {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference employecol =
      FirebaseFirestore.instance.collection("Employe_Client");
  Future saveUser(UserM user) async {
    try {
      await usercol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUser(String id) async {
    try {
      final data = await usercol.doc(id).get();
      final user = UserM.fromJson(data.data() as Map<String, dynamic>);
      return user;
    } catch (e) {
      return false;
    }
  }

  Future saveEmploye(EmployeM employe) async {
    try {
      await employecol.doc(employe.id).set(employe.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getEmploye(String id) async {
    try {
      final data = await employecol.doc(id).get();
      final employe = EmployeM.fromJson(data.data() as Map<String, dynamic>);
      return employe;
    } catch (e) {
      return false;
    }
  }

  Stream<List<EmployeM>> get employe {
    Query queryemploye = FirebaseFirestore.instance
        .collection("Employe_Client")
        .orderBy('id', descending: true);
    return queryemploye.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EmployeM(
            id: doc.id,
            name: doc.get('Name'),
            tel: doc.get('tel'),
            lat: doc.get('lat'),
            long: doc.get('long'),
            role: doc.get('role'));
      }).toList();
    });
  }
}
