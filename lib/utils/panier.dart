// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:auth/screens/articlePanier.dart';

class panier {
  late List<articlePanier> a;
  late double total;

  panier(articlePanier b) {
    a.first = b;
    total = b.prix;
  }
  String toString() {
    int i = 0;
    String chaine = "";
    for (var n in a) {
      chaine = a[i].nomArticle +
          "quantite : " +
          a[i].quantite.toString() +
          " prix total : " +
          a[i].total.toString();
      i++;
    }
    return chaine;
  }

  void ajouteraupanier(articlePanier article) {
    this.a.add(article);
    total = total + article.prix;
  }

  void retirerdupanier(articlePanier article) {
    this.a.remove(article);
    total = total - article.prix;
  }
}
