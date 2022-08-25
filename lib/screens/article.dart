// ignore_for_file: sort_child_properties_last, camel_case_types, unused_element, unnecessary_new, prefer_const_constructors, deprecated_member_use

import 'package:auth/screens/prise_de_commande.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'articlePanier.dart';

class ArticlesInformation extends StatefulWidget {
  const ArticlesInformation({Key? key}) : super(key: key);

  @override
  State<ArticlesInformation> createState() => _ArticlesInformationState();
}

class _ArticlesInformationState extends State<ArticlesInformation> {
  articlePanier a = articlePanier(0, "", 0);
  var panier = <articlePanier>[];
  int i = 0;

  final Stream<QuerySnapshot> _articlesInformation =
      FirebaseFirestore.instance.collection('Article').snapshots();
  var nbClick = Map<String, int>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
        child: Text('Nouvelle commande'),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Type de livraison'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: <Widget>[
        Column(
          children: [
            Row(
              children: [
                IconButton(
                    iconSize: 72,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return startCommande();
                      }));
                    },
                    icon: Icon(Icons.phone)),
                IconButton(
                    iconSize: 72,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return startCommande();
                      }));
                    },
                    icon: Text('Uber')),
                IconButton(
                    iconSize: 72,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return startCommande();
                      }));
                    },
                    icon: Text('Deliveroo')),
                IconButton(
                    iconSize: 72,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return startCommande();
                      }));
                    },
                    icon: Text("Just-Eat")),
              ],
            )
          ],
        ),
      ],
    );
  }
}
