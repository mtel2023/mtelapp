import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mtelapp/models/proizvod.dart';
import 'dart:convert';

class Proizvodi with ChangeNotifier {
  List<Proizvod> _items = [];

  String? authToken;
  Proizvodi(this.authToken, this._items);

  List<Proizvod> get listaProizvoda {
    return [..._items];
  }

  Future<void> readProizvode() async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/proizvodi.json?auth=$authToken');
    await http.get(url).then((response) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      // print(data);

      final List<Proizvod> loadedProizvodi = [];
      data.forEach((key, data) {
        loadedProizvodi.add(Proizvod(
          id: key,
          ime: data['ime'],
          cijena: data['cijena'],
          imageUrl: data['imageUrl'],
        ));
        _items = loadedProizvodi;
        notifyListeners();
      });
    });
  }

  Future<void> addProizvod(String ime, double cijena, String imageUrl) async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/proizvodi.json');
    print(ime);
    print(cijena);
    print(imageUrl);

    final response = await http
        .post(
      url,
      body: json.encode(
        {
          'ime': ime,
          'cijena': cijena,
          'imageUrl': imageUrl,
        },
      ),
    )
        .then(
      (value) {
        notifyListeners();
      },
    );
  }
}
