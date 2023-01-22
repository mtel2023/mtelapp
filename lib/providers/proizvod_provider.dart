import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mtelapp/models/http_exception.dart';
import 'package:mtelapp/models/proizvod.dart';
import 'dart:convert';

class Proizvodi with ChangeNotifier {
  List<Proizvod> _items = [];
  List<Proizvod> _searchItems = [];
  String? authToken;
  Proizvodi(this.authToken, this._items);

  List<Proizvod> get listaProizvoda {
    return [..._items];
  }

  List<Proizvod> get getSearchItems {
    return [..._searchItems];
  }

  Future<void> readProizvode() async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/proizvodi.json?auth=$authToken');
    try {
      final response = await http.get(url).then((response) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        final List<Proizvod> loadedProizvodi = [];
        data.forEach((key, data) {
          loadedProizvodi.add(Proizvod(
            id: key,
            ime: data['ime'],
            cijena: data['cijena'],
            imageUrl: data['imageUrl'],
            litara_kg: data['litara_kg'],
          ));
          _items = loadedProizvodi;
          notifyListeners();
        });
        final responseData = json.decode(response.body);
        if (responseData['error'] != null) {
          throw HttpException(responseData['error']['message']);
        }
      });
    } on Exception catch (exception) {
      throw exception;
    } catch (e) {
      throw e;
    }
  }

  Future<void> readProizvodePoMarketId(String marketId) async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/marketi/$marketId.json?auth=$authToken');
    try {
      final response = await http.get(url).then((value) {
        final extractedData = json.decode(value.body) as Map<String, dynamic>;
        final List<Proizvod> loadedProizvodi = [];

        extractedData['proizvodi'].forEach((key, data) {
          loadedProizvodi.add(Proizvod(
            id: key,
            ime: extractedData['proizvodi'][key]['ime'],
            cijena: extractedData['proizvodi'][key]['cijena'],
            imageUrl: extractedData['proizvodi'][key]['imageUrl'],
            litara_kg: extractedData['proizvodi'][key]['litara_kg'],
          ));
          _items = loadedProizvodi;
          notifyListeners();
        });
      });
    } catch (e) {
      throw e;
    }
  }

  void clearSearchProizvodi() {
    _searchItems.clear();
  }

  void searchProizvod(String value) {
    _searchItems = [];
    _items.forEach(
      (element) {
        if (element.ime.toLowerCase().contains(value.toLowerCase())) {
          _searchItems.add(
            Proizvod(
              id: element.id,
              ime: element.ime,
              cijena: element.cijena,
              imageUrl: element.imageUrl,
              litara_kg: element.litara_kg,
            ),
          );

          notifyListeners();
        }
      },
    );
  }

  Future<void> addProizvod({required String ime, required double cijena, required String imageUrl, required String marketId, required String litara_kg}) async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/marketi/$marketId/proizvodi/.json?auth=$authToken');

    try {
      final response = await http
          .post(
        url,
        body: json.encode(
          {
            'ime': ime,
            'cijena': cijena,
            'imageUrl': imageUrl,
            'litara_kg': litara_kg,
          },
        ),
      )
          .then(
        (value) {
          notifyListeners();
        },
      );
    } catch (e) {
      throw e;
    }
  }
}
