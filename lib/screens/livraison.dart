// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:auth/main.dart';
import 'package:auth/models/employeM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../database/db.dart';
import '../utils/utils.dart';

const double ZOOM = 12;

class Livraison extends StatefulWidget {
  const Livraison({Key? key}) : super(key: key);

  @override
  State<Livraison> createState() => _LivraisonState();
}

class _LivraisonState extends State<Livraison> {
  GoogleMapController? _googleMapController = null;
  Set<Marker> markers = Set();

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Employe_Client").snapshots(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            final nblivreur = (snapshot.data! as QuerySnapshot).size;
            //Extract the location from document
            var tab = <Map>[];
            Map<String, List<int>> myMapList = Map();
            for (final doc in (snapshot.data! as QuerySnapshot).docs) {
              tab.add({
                'long': doc.get("long"),
                'lat': doc.get("lat"),
                'name': doc.get("name"),
              });
            }
            markers.clear();
            LatLng latLng = LatLng(0, 0);
            double lat = 0;
            double long = 0;
            print('taille tab :' + tab.length.toString());
            for (var element in tab) {
              print(element["name"]);
              latLng = LatLng(element["lat"], element['long']);
              lat = element['lat'];
              long = element['long'];
              markers.add(Marker(
                  markerId: MarkerId(element['name']),
                  position: latLng,
                  infoWindow: InfoWindow(
                    title: element['name'],
                  )));
            }

            // If google map is already created then update camera position with animation
            _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: latLng,
                zoom: ZOOM,
              ),
            ));

            return GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(lat, long), zoom: 13),
              // Markers to be pointed
              markers: markers,
              onMapCreated: _onMapCreated,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
