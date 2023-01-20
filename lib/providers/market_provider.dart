import 'package:flutter/foundation.dart';
import 'package:mtelapp/models/market.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mtelapp/models/proizvod.dart';

class Marketi with ChangeNotifier {
  List<Market> _marketi = [];

  String? authToken;
  Marketi(this.authToken, this._marketi);

  List<Market> get listaMarketa {
    return [..._marketi];
  }

  Future<void> readMarkete() async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/marketi.json?auth=$authToken');
    final response = await http.get(url).then((value) {
      final data = json.decode(value.body);
      final List<Market> loadedMarketi = [];
      data.forEach((key, data) {
        loadedMarketi.add(Market(id: key, ime: data['ime'], logo: data['logo'], proizvodi: []));
        _marketi = loadedMarketi;
        notifyListeners();
      });
    });
  }

  Future<void> addMarket(
    String ime,
    String logo,
    List<Proizvod> proizvodi,
  ) async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/marketi.json?auth=$authToken');
    final response = await http
        .post(url,
            body: json.encode(
              {
                'ime': ime,
                'logo': logo,
                'proizvodi': [],
              },
            ))
        .then((value) {
      notifyListeners();
    });
  }
}
