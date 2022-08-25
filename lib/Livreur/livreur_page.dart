// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, dead_code, unused_element, unnecessary_const, avoid_print, non_constant_identifier_names, unnecessary_new, unused_local_variable

import 'dart:async';

import 'package:auth/Livreur/Commande_cours_livreur.dart';
import 'package:auth/Livreur/LivraisonLivreur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LivreurPage extends StatefulWidget {
  @override
  State<LivreurPage> createState() => _LivreurPageState();
}

class _LivreurPageState extends State<LivreurPage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    LivraisonLivreur(),
    Commande_cours_livreur(),
  ];
  late Future<LocationData> currentLocation;
  late Location location;

  @override
  void initState() {
    location = new Location();
    currentLocation = location.getLocation();
    FutureBuilder(
        future: currentLocation,
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                print('b');
                return new Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                print('a');
                return new Center(
                  child: Text(''),
                );
              }
            default:
              return new Text('');
          }
        });
    _asyncMethod();
    setState(() {});
    super.initState();
  }

  _asyncMethod() async {
    double i = 0;
    Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      Position pos = await _determinePosition();
      FirebaseFirestore.instance
          .collection('Employe_Client')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'lat': pos.latitude,
        'long': pos.longitude,
      });
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

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
          fixedColor: Colors.white,
          iconSize: 27,
          unselectedItemColor: Colors.black,
          unselectedFontSize: 14,
          showUnselectedLabels: true,
          backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining_rounded),
              label: 'Livraison',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline_rounded),
              label: 'Commande',
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
