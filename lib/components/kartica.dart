import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Kartica extends StatelessWidget {
  final IconData ikonica;
  final String tekst;
  const Kartica({required this.ikonica, required this.tekst});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -1,
            blurRadius: 5,
            offset: Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 35),
          Icon(
            ikonica,
            size: 34,
          ),
          SizedBox(width: 10),
          Text(
            tekst,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
