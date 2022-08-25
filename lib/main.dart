// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'dart:async';

import 'package:auth/database/db.dart';
import 'package:auth/models/employeM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/auth_page.dart';
import 'utils/verify_email_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(
    /*MultiProvider(
      providers: [
        StreamProvider<List<EmployeM>>.value(
          initialData: [],
          value: DBservices().employe,
        )
      ],
      child: */
    MyApp(),
    // ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        title: 'Mon resto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  final employes = FirebaseFirestore.instance.collection("Employe_Client");
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('something went wrong'),
                );
              } else if (snapshot.hasData) {
                final docRef =
                    db.collection("Utilisateur").doc("N0NLCSlTPQjTcgDrslwM");
                docRef.get().then(
                  (DocumentSnapshot doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    print(data['Nom']);
                  },
                  onError: (e) => print(e),
                );
                return VerifyEmailPage();
              } else {
                return AuthPage();
              }
            }),
      );
}
