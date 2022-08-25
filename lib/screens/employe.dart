// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Employe extends StatefulWidget {
  const Employe({Key? key}) : super(key: key);

  @override
  State<Employe> createState() => _EmployeState();
}

class _EmployeState extends State<Employe> {
  final formKey = GlobalKey<FormState>();
  final nom = TextEditingController();
  final id = TextEditingController();
  final tel = TextEditingController();
  final mail = TextEditingController();
  final mdp = TextEditingController();
  @override
  void dispose() {
    nom.dispose();
    id.dispose();
    tel.dispose();
    mail.dispose();
    mdp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Employe_Client").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Panier"),
                  leading: GestureDetector(
                    onTap: () {/* Write listener code here */},
                    child: Icon(
                      Icons.menu, // add custom icons also
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 500),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  addEmploye(context),
                            );
                          },
                          child: Text("Add employe"),
                        )),
                  ],
                ),
                body: ListView(
                  padding: const EdgeInsets.all(8),
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        Color _color() {
                          Color a = Colors.grey;
                          if (data['connecter'] == true) a = Colors.green;
                          return a;
                        }

                        return Column(children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4.1,
                                height: 50,
                                color: _color(),
                                child: Center(child: Text(data['role'])),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4.1,
                                height: 50,
                                color: _color(),
                                child: Center(child: Text(data['name'])),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4.1,
                                height: 50,
                                color: _color(),
                                child: Center(child: Text(data['tel'])),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(context, data),
                                  );
                                },
                                child: const Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ]);
                      })
                      .toList()
                      .cast(),
                ));
          }
          return Text('data');
        });
  }

  Widget addEmploye(BuildContext context) {
    return new AlertDialog(
      title: const Text('Information '),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: <Widget>[
        SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nom,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'nom de l"employe'),
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: tel,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'tel'),
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: id,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'id'),
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: mail,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'mail'),
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: mdp,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'mdp'),
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        //minimumSize: Size(50, 10),
                        ),
                    icon: Icon(Icons.add, size: 32),
                    label: Text(
                      'ajouter',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      _addlivreur();
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }

  void _addlivreur() async {
    final doc = FirebaseFirestore.instance
        .collection('Employe_Client')
        .doc(id.text.trim());
    final livreur = FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail.text.trim(), password: mdp.text.trim());

    await doc.set({
      'name': nom.text.trim(),
      'id': id.text.trim(),
      'lat': 0,
      'long': 0,
      'connecter': false,
      'role': "livreur",
      'tel': tel.text.trim()
    });
  }
}

_buildPopupDialog(BuildContext context, data) {
  return new AlertDialog(
    title: const Text('Information '),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    actions: <Widget>[
      ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Employe_Client')
                .doc(data['id'])
                .delete();
          },
          child: Text("Confirmer la supression ")),
    ],
  );
}
