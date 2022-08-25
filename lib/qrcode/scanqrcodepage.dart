import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:auth/Livreur/Commande_cours_livreur.dart';

class qrcode extends StatefulWidget {
  const qrcode({Key? key}) : super(key: key);

  @override
  State<qrcode> createState() => _qrcodeState();
}

class _qrcodeState extends State<qrcode> {
  Commande_cours_livreur a = Commande_cours_livreur();
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  int compteur = 0;
  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 350,
              width: 400,
              child: QRView(key: _gLobalkey, onQRViewCreated: qr),
            ),
            Center(
              child: (result != null)
                  ? ElevatedButton(
                      onPressed: () {
                        print(result!.code);
                        Map<String, dynamic> data = {'qrcode': result!.code};
                        if (FirebaseFirestore.instance
                            .collection("Commande_en_cours")
                            .doc(result!.code)
                            .id
                            .isNotEmpty) {
                          FirebaseFirestore.instance
                              .collection("Commande_en_cours")
                              .doc(result!.code)
                              .update({
                            'livreur_id': FirebaseAuth.instance.currentUser!.uid
                          });
                        }
                        Navigator.pop(context, true);
                      },
                      child: Text('commencer livraison'))
                  : Text('Scan a code'),
            )
          ],
        ),
      ),
    );
  }
}
