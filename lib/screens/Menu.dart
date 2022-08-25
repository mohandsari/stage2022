// ignore_for_file: unnecessary_new, unused_element, prefer_const_constructors

import 'package:auth/screens/articlePanier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<double> panierprix = [];
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Panier").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (!snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      child: Center(child: Text('Total : ' + total.toString())),
                      onPressed: () {},
                    )),
              ),
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
                      padding: EdgeInsets.only(right: 100.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Menu"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 100.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Burger"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 100.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Sides"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 100.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Boisson"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 100.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Dessert"),
                      )),
                ],
              ),
              body: Center(child: Text("Panier vide")),
            );
          }
          if (snapshot.hasData) {
            priajour();
            return Scaffold(
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Container(
                    height: 50.0,
                    child: Center(
                      child: Row(children: [
                        Text('Total : ' + total.toString()),
                        ElevatedButton(
                            onPressed: () {
                              priajour();
                            },
                            child: Text("pri"))
                      ]),
                    )),
              ),
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
                      padding: EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                MenuView(context),
                          );
                        },
                        child: Text("Menu"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                BurgerView(context),
                          );
                        },
                        child: Text("Burger"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                SidesView(context),
                          );
                        },
                        child: Text("Sides"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                BoissonView(context),
                          );
                        },
                        child: Text("Boisson"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DessertView(context),
                          );
                        },
                        child: Text("Dessert"),
                      )),
                  Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                BoissonMenuView(context),
                          );
                        },
                        child: Text("BoissonMenu"),
                      )),
                ],
              ),
              body: ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      panierprix.add(data['prix'] * data['quantite']);
                      priajour();
                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 4,
                              top: 5,
                            ),
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            decoration:
                                BoxDecoration(color: const Color(0xff7c94b6)),
                            child: Center(
                                child: Text(data['nom'] +
                                    ' : ' +
                                    data['prix'].toString() +
                                    '  quantite : ' +
                                    data['quantite'].toString())),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Panier')
                                    .doc(data['id'])
                                    .update({
                                  'quantite': data['quantite'] + 1,
                                });
                              },
                              child: const Icon(Icons.add)),
                          ElevatedButton(
                              onPressed: () {
                                if (data['quantite'] == 1) {
                                  FirebaseFirestore.instance
                                      .collection('Panier')
                                      .doc(data['id'])
                                      .delete();
                                } else {
                                  FirebaseFirestore.instance
                                      .collection('Panier')
                                      .doc(data['id'])
                                      .update({
                                    'quantite': data['quantite'] - 1,
                                  });
                                }
                              },
                              child: Icon(Icons.remove)),
                        ],
                      );
                    })
                    .toList()
                    .cast(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(title: const Text('Aucune commande en cours ')),
          );
        });
  }

  String priajour() {
    for (int a = 0; a < panierprix.length; a++) {
      total = panierprix[a];
      print(total);
    }
    return total.toString();
  }
}

Widget MenuView(BuildContext context) {
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
                  _addPanierArticle("Menu O'36", 12.5);
                },
                icon: Text("Menu O'36, 12,50€"),
              ),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Classic", 11.5);
                  },
                  icon: Text('Menu Classic 11,50€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Harlem", 14);
                  },
                  icon: Text('Menu Harlem 14,00€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Alpin", 14.5);
                  },
                  icon: Text("Menu Alpin 14,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Marin", 14);
                  },
                  icon: Text("Menu Marin 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Braisé", 13.5);
                  },
                  icon: Text("Menu Braisé 13,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Chicanos", 14);
                  },
                  icon: Text("Menu Chicanos 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Milano", 14);
                  },
                  icon: Text("Menu Milano 14,00€")),
            ],
          )
        ],
      ),
    ],
  );
}

Widget BoissonMenuView(BuildContext context) {
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
                  _addPanierArticle("Coca-Cola", 0);
                },
                icon: Text("Coca-Cola, 0€"),
              ),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Coca-Cola zéro", 0);
                  },
                  icon: Text('Coca-Cola zéro ')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Coca-Cola cherry", 2.0);
                  },
                  icon: Text("Coca-Cola cherry ")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Alpin", 14.5);
                  },
                  icon: Text("Menu Alpin 14,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Marin", 14);
                  },
                  icon: Text("Menu Marin 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Braisé", 13.5);
                  },
                  icon: Text("Menu Braisé 13,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Chicanos", 14);
                  },
                  icon: Text("Menu Chicanos 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Milano", 14);
                  },
                  icon: Text("Menu Milano 14,00€")),
            ],
          )
        ],
      ),
    ],
  );
}

Widget BurgerView(BuildContext context) {
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
                  _addPanierArticle("Menu O'36", 12.5);
                },
                icon: Text("Menu O'36, 12,50€"),
              ),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Classic", 11.5);
                  },
                  icon: Text('Menu Classic 11,50€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Harlem", 14);
                  },
                  icon: Text('Menu Harlem 14,00€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Alpin", 14.5);
                  },
                  icon: Text("Menu Alpin 14,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Marin", 14);
                  },
                  icon: Text("Menu Marin 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Braisé", 13.5);
                  },
                  icon: Text("Menu Braisé 13,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Chicanos", 14);
                  },
                  icon: Text("Menu Chicanos 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Milano", 14);
                  },
                  icon: Text("Menu Milano 14,00€")),
            ],
          )
        ],
      ),
    ],
  );
}

Widget BoissonView(BuildContext context) {
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
                  _addPanierArticle("Menu O'36", 12.5);
                },
                icon: Text("Menu O'36, 12,50€"),
              ),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Classic", 11.5);
                  },
                  icon: Text('Menu Classic 11,50€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Harlem", 14);
                  },
                  icon: Text('Menu Harlem 14,00€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Alpin", 14.5);
                  },
                  icon: Text("Menu Alpin 14,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Marin", 14);
                  },
                  icon: Text("Menu Marin 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Braisé", 13.5);
                  },
                  icon: Text("Menu Braisé 13,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Chicanos", 14);
                  },
                  icon: Text("Menu Chicanos 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Milano", 14);
                  },
                  icon: Text("Menu Milano 14,00€")),
            ],
          )
        ],
      ),
    ],
  );
}

Widget SidesView(BuildContext context) {
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
                  _addPanierArticle("Menu O'36", 12.5);
                },
                icon: Text("Menu O'36, 12,50€"),
              ),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Classic", 11.5);
                  },
                  icon: Text('Menu Classic 11,50€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Harlem", 14);
                  },
                  icon: Text('Menu Harlem 14,00€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Alpin", 14.5);
                  },
                  icon: Text("Menu Alpin 14,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Marin", 14);
                  },
                  icon: Text("Menu Marin 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Braisé", 13.5);
                  },
                  icon: Text("Menu Braisé 13,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Chicanos", 14);
                  },
                  icon: Text("Menu Chicanos 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Milano", 14);
                  },
                  icon: Text("Menu Milano 14,00€")),
            ],
          )
        ],
      ),
    ],
  );
}

Widget DessertView(BuildContext context) {
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
                  _addPanierArticle("Menu O'36", 12.5);
                },
                icon: Text("Menu O'36, 12,50€"),
              ),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Classic", 11.5);
                  },
                  icon: Text('Menu Classic 11,50€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Harlem", 14);
                  },
                  icon: Text('Menu Harlem 14,00€')),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Alpin", 14.5);
                  },
                  icon: Text("Menu Alpin 14,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Marin", 14);
                  },
                  icon: Text("Menu Marin 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Braisé", 13.5);
                  },
                  icon: Text("Menu Braisé 13,50€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Chicanos", 14);
                  },
                  icon: Text("Menu Chicanos 14,00€")),
              IconButton(
                  iconSize: 72,
                  onPressed: () {
                    _addPanierArticle("Menu Milano", 14);
                  },
                  icon: Text("Menu Milano 14,00€")),
            ],
          )
        ],
      ),
    ],
  );
}

void _addPanierArticle(String name, double prix) async {
  final doc = FirebaseFirestore.instance.collection('Panier').doc(name);

  await doc.set({'nom': name, 'id': name, 'prix': prix, 'quantite': 1});
}
