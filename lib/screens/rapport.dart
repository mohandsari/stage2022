import 'package:flutter/material.dart';

class Rapport extends StatefulWidget {
  const Rapport({Key? key}) : super(key: key);

  @override
  State<Rapport> createState() => _RapportState();
}

class _RapportState extends State<Rapport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Rapport"),
    );
  }
}
