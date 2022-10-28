// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/src/widgets/framework.dart';

class Commande_cours_livreur extends StatefulWidget {
  const Commande_cours_livreur({Key? key}) : super(key: key);

  @override
  State<Commande_cours_livreur> createState() => _Commande_cours_livreurState();
}

class _Commande_cours_livreurState extends State<Commande_cours_livreur> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Commande_en_cours")
          .where('livreur_id',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if (snapshot.hasData) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4.1,
                          height: 50,
                          color: Colors.amber[400],
                          child: Center(child: Text(data['type'])),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4.1,
                          height: 50,
                          color: Colors.amber[500],
                          child: Center(child: Text(data['nom_client'])),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4.1,
                          height: 50,
                          color: Colors.amber[400],
                          child: Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      data['tel']);
                                },
                                child: Icon(Icons.call)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4.1,
                          height: 50,
                          color: Colors.amber[500],
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(context, data['id']),
                                );
                              },
                              child: Icon(Icons.cancel),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]);
                })
                .toList()
                .cast(),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Aucune commande en cours ')),
        );
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context, String id) {
    return new AlertDialog(
      title: const Text('Livraison Terminer ?'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Cliquer sur confirmer "),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text('Close'),
        ),
        new TextButton(
          onPressed: () {
            final docuser = FirebaseFirestore.instance
                .collection('Commande_en_cours')
                .doc(id);
            docuser.delete().then(
                  (doc) => print("Document deleted"),
                  onError: (e) => print("Error updating document $e"),
                );
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}
