import 'package:flutter/foundation.dart';
import 'package:mtelapp/models/http_exception.dart';
import 'package:mtelapp/models/korpa_item.dart';
import 'package:http/http.dart' as http;
import 'package:mtelapp/models/order.dart';
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
  late OrderItem _lastOrder;
  late OrderItem _loadedOrder;
  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);
  List<OrderItem> get getOrders {
    return [..._orders];
  }

  OrderItem get lastOrder {
    _lastOrder = _orders[0];
    // _orders.removeAt(0);
    return _lastOrder;
  }

  OrderItem get getLoadedOrder {
    return _loadedOrder;
  }

  void readOrderById(String orderId) async {
    _loadedOrder = _orders.firstWhere((element) => element.id == orderId);

    print(_loadedOrder.total);
  }

  Future<void> readOrders() async {
    final url = Uri.parse('https://mtelapp-ac423-default-rtdb.europe-west1.firebasedatabase.app/orders/$userId.json?auth=$authToken');

    final response = await http.get(url);

    if (response.body == 'null') {
      _orders = [];

      return;
    }
    final List<OrderItem> loadedOrders = [];

    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          total: double.parse(orderData['total']),
          vrijeme: DateTime.parse(orderData['vrijeme']),
          proizvodi: (orderData['proizvodi'] as List<dynamic>)
              .map(
                (proizvod) => KorpaItem(
                  id: proizvod['id'],
                  ime: proizvod['ime'],
                  cijena: proizvod['cijena'],
                  imageUrl: proizvod['imageUrl'],
                  kolicina: proizvod['kolicina'],
                  litara_kg: proizvod['litara_kg'],
                ),
              )
              .toList(),
        ),
      );
    });
    final responseData = json.decode(response.body);

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
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
                    'kolicina': proizvod.kolicina,
                    'litara_kg': proizvod.litara_kg,
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
      throw e;
    }
  }
}
