// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, dead_code, unused_element, unnecessary_const, avoid_print, non_constant_identifier_names

import 'package:auth/screens/article.dart';
import 'package:auth/screens/client.dart';
import 'package:auth/screens/employe.dart';
import 'package:auth/screens/rapport.dart';
import 'package:auth/screens/stock.dart';
import 'package:flutter/material.dart';
import 'Marketing.dart';

import 'livraison.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("geeksforgeeks"),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Employe_Client').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .where((a) => a == "Livreur")
                .map((document) {
              if (document['Role'] == "Livreur") {
                return LivreurHomePage();
              }
              return Container(
                child: Center(child: Text(document['Role'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }*/
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    Livraison(),
    Stock(),
    Employe(),
    //Caisse(),
    ArticlesInformation(),
    Client(),
    Marketing(),
    Rapport(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Homiiie'),
          backgroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xff764abc),
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.amber,
          iconSize: 27,
          unselectedItemColor: Colors.black,
          unselectedFontSize: 14,
          showUnselectedLabels: true,
          backgroundColor: Colors.amber,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining_rounded),
              label: 'Livraison',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_rounded),
              label: 'stock',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.engineering),
              label: 'Employé',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_rounded),
              label: 'Caisse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded),
              label: 'Client',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_tree_rounded),
              label: 'Marketing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline_rounded),
              label: 'Rapport',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class CuisinierHomePage extends StatefulWidget {
  const CuisinierHomePage({Key? key}) : super(key: key);

  @override
  State<CuisinierHomePage> createState() => _CuisinierHomePageState();
}

class _CuisinierHomePageState extends State<CuisinierHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('livreur')),
    );
  }
}

class LivreurHomePage extends StatefulWidget {
  const LivreurHomePage({Key? key}) : super(key: key);

  @override
  State<LivreurHomePage> createState() => _LivreurHomePageState();
}

class _LivreurHomePageState extends State<LivreurHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('livreur')),
    );
  }
}
