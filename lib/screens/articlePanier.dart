import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class articlePanier {
  double prix = 0;
  double total = 0;
  int quantite = 0;
  String nom = "";

  articlePanier(double prix, String nom, int quantite) {
    this.prix = prix;
    this.nom = nom;
    this.quantite = quantite;
    this.total = prix;
  }

  void firebaseArticle() {
    final Stream<QuerySnapshot> _articlesInformation =
        FirebaseFirestore.instance.collection('Article').snapshots();
    StreamBuilder<QuerySnapshot>(
        stream: _articlesInformation,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            this.prix = data['prix'];
            this.nom = data['Nom'];
          });
          return Center();
        });
  }

  addQuantity() {
    this.total = total + this.prix;
    this.quantite = this.quantite + 1;
  }

  reduceQuantity() {
    if (quantite > 0 && total >= prix) {
      this.quantite = this.quantite - 1;
      this.total = this.total - prix;
    }
  }

  double get prixArticle {
    return prix;
  }

  int get quantiteArticle {
    return quantite;
  }

  double get totalArticle {
    return total;
  }

  String get nomArticle {
    return nom;
  }

  bool isNull() {
    if (quantite == 0) {
      return true;
    } else {
      return false;
    }
  }

  void set quantiteArticle(int quantite) {
    this.quantite = quantite;
    this.total = quantite * prix;
  }

  String toString() {
    if (quantite > 0) {
      return "Article : " +
          this.nom +
          " quantite : " +
          this.quantite.toString() +
          " prix : " +
          this.prix.toString() +
          " prix total : " +
          this.total.toString();
    } else {
      return "";
    }
  }
}
