import 'package:auth/screens/Menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class startCommande extends StatefulWidget {
  const startCommande({Key? key}) : super(key: key);

  @override
  State<startCommande> createState() => _startCommandeState();
}

class _startCommandeState extends State<startCommande> {
  final formKey = GlobalKey<FormState>();
  final nom_client = TextEditingController();
  final adresse = TextEditingController();
  final tel = TextEditingController();
  final code_postal = TextEditingController();
  final ville = TextEditingController();

  @override
  void dispose() {
    nom_client.dispose();
    adresse.dispose();
    tel.dispose();
    code_postal.dispose();
    ville.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                TextFormField(
                  controller: nom_client,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'nom du client'),
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
                  controller: adresse,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'adresse'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: code_postal,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'code postal'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: ville,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'ville'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      //minimumSize: Size(50, 10),
                      ),
                  icon: Icon(Icons.lock_open, size: 32),
                  label: Text(
                    'Commencer',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Menu();
                    }));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
