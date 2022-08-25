import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetLat extends StatelessWidget {
  final String documentId;

  GetLat(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference employe =
        FirebaseFirestore.instance.collection('Employe_Client');

    return FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the student
      future: employe.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return data['lat'];
        }

        return Text("loading");
      },
    );
  }
}
