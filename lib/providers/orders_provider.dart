import 'package:flutter/foundation.dart';
import 'package:mtelapp/models/http_exception.dart';
import 'package:mtelapp/models/korpa_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mtelapp/models/proizvod.dart';

class OrderItem {
  final String id;
  final double total;
  final List<KorpaItem> proizvodi;
  final DateTime vrijeme;

  OrderItem({required this.id, required this.total, required this.proizvodi, required this.vrijeme});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> readOrders() async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
  }

  Future<void> addOrder(double total, List<KorpaItem> korpaProizvodi) async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    try {
      if (total == 0) {
        return;
      }

      final response = await http.post(
        url,
        body: json.encode(
          {
            'total': total.toStringAsFixed(2),
            'vrijeme': DateTime.now().toIso8601String(),
            'proizvodi': korpaProizvodi
                .map(
                  (proizvod) => {
                    'id': proizvod.id,
                    'ime': proizvod.ime,
                    'imageUrl': proizvod.imageUrl,
                    'cijena': proizvod.cijena,
                  },
                )
                .toList(),
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
