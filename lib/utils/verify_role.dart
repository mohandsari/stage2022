// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:ffi';
import 'package:auth/Livreur/livreur_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/screens/home_page.dart';
import 'utils.dart';

class VerifyRole extends StatefulWidget {
  @override
  State<VerifyRole> createState() => _VerifyRolePageState();
}

class _VerifyRolePageState extends State<VerifyRole> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Employe_Client")
            .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            //Extract the location from document
            final role =
                (snapshot.data! as QuerySnapshot).docs.first.get("role");
            if (role == 'livreur')
              return LivreurPage();
            else
              return HomePage();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
