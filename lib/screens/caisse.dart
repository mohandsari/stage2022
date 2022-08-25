// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Caisse extends StatefulWidget {
  const Caisse({Key? key}) : super(key: key);

  @override
  State<Caisse> createState() => _CaisseState();
}

class _CaisseState extends State<Caisse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Caisse"),
    );
  }
}
