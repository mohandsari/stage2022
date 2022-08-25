// ignore_for_file: prefer_const_constructors

import 'package:auth/qrcode/scanqrcodepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LivraisonLivreur extends StatefulWidget {
  const LivraisonLivreur({Key? key}) : super(key: key);

  @override
  State<LivraisonLivreur> createState() => _LivraisonLivreurState();
}

class _LivraisonLivreurState extends State<LivraisonLivreur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const qrcode()),
          );
        },
        icon: Icon(Icons.add, size: 18),
        label: Text("Livraison"),
      )),
    );
  }
}
