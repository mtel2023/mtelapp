import 'package:Trebovanje/models/proizvod.dart';

class Market {
  final String id;
  final String ime;
  final String logo;
  final List<Proizvod> proizvodi;
  Market({
    required this.id,
    required this.ime,
    required this.logo,
    required this.proizvodi,
  });
}
