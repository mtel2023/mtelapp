import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mtelapp/models/korpa_item.dart';

class Korpa with ChangeNotifier {
  late Map<String, KorpaItem> _items;
  late KorpaItem _deletedItem;

  String? authToken;

  Korpa(this.authToken, this._items);
  Map<String, KorpaItem> get items {
    return {..._items};
  }

  KorpaItem get getDeletedItem {
    return _deletedItem;
  }

  double get total {
    double total = 0;
    _items.forEach((key, korpaItem) {
      total += korpaItem.cijena * korpaItem.kolicina;
    });
    return total;
  }

  void addItem(String proizvodId, double cijena, String ime, String imageUrl) {
    if (_items.containsKey(proizvodId)) {
      _items.update(
        proizvodId,
        (postojeciProizvod) => KorpaItem(id: postojeciProizvod.id, ime: postojeciProizvod.ime, kolicina: postojeciProizvod.kolicina + 1, cijena: postojeciProizvod.cijena, imageUrl: postojeciProizvod.imageUrl),
      );
    } else {
      _items.putIfAbsent(
        proizvodId,
        () => KorpaItem(
          id: proizvodId,
          ime: ime,
          kolicina: 1,
          cijena: cijena,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void smanjiKolicinu(String proizvodId) {
    if (_items.containsKey(proizvodId)) {
      _items.update(
        proizvodId,
        (postojeciProizvod) => KorpaItem(id: postojeciProizvod.id, ime: postojeciProizvod.ime, kolicina: postojeciProizvod.kolicina - 1, cijena: postojeciProizvod.cijena, imageUrl: postojeciProizvod.imageUrl),
      );
    }

    notifyListeners();
  }

  void restore(_deletedItem) {
    _items.putIfAbsent(
      _deletedItem.id,
      () => KorpaItem(
        id: _deletedItem.id,
        ime: _deletedItem.ime,
        kolicina: _deletedItem.kolicina,
        cijena: _deletedItem.cijena,
        imageUrl: _deletedItem.imageUrl,
      ),
    );
    notifyListeners();
  }

  void deleteItem(String proizvodId) {
    _deletedItem = _items[proizvodId]!;

    _items.remove(proizvodId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
