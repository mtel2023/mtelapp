import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
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

class ChartSampleData {
  ChartSampleData({required this.x, required this.y});
  final String x;
  final double y;
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<ChartSampleData> _statistikaOrders = [];
  double _statistikaTotal = 0;
  late OrderItem _lastOrder;
  late OrderItem _loadedOrder;

  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);
  List<OrderItem> get getOrders {
    return [..._orders];
  }

  double get getStatistikaTotal {
    return _statistikaTotal;
  }

  OrderItem get lastOrder {
    _lastOrder = _orders[0];
    // _orders.removeAt(0);
    return _lastOrder;
  }

  OrderItem get getLoadedOrder {
    return _loadedOrder;
  }

  List<ChartSampleData> get getStatistikaOders {
    _statistikaOrders.sort((a, b) => b.x.compareTo(a.x));
    // _statistikaOrders.forEach((element) {
    //   print(element.x);
    // });
    return [..._statistikaOrders];
  }

  Future<void> readOrdersByDate(DateTime startDate, DateTime endDate) async {
    _statistikaTotal = 0;
    double danTotal = 0;
    Map<String, int>? danVrijeme;
    _statistikaOrders = [];
    _orders.sort((a, b) => a.vrijeme.compareTo(b.vrijeme));
    // _orders.forEach((element) {
    //   print('${element.vrijeme.day} = ${element.total}');
    // });
    _orders.forEach((order) {
      if (order.vrijeme.isAfter(startDate) && order.vrijeme.isBefore(endDate)) {
        if (danVrijeme == null) {
          danVrijeme = {'dan': order.vrijeme.day, 'mesec': order.vrijeme.month};
        }

        if (order.vrijeme.day == danVrijeme!['dan'] && order.vrijeme.month == danVrijeme!['mesec']) {
          danTotal += order.total;
        } else {
          danTotal = order.total;
          danVrijeme = {'dan': order.vrijeme.day, 'mesec': order.vrijeme.month};
        }
        _statistikaOrders.add(ChartSampleData(x: DateFormat('dd MMM').format(order.vrijeme), y: danTotal));
        _statistikaTotal += order.total;
      }
    });
    notifyListeners();
  }

  void readOrderById(String orderId) async {
    _loadedOrder = _orders.firstWhere((element) => element.id == orderId);
    notifyListeners();
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
