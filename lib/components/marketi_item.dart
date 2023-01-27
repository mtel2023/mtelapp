import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:Trebovanje/providers/proizvod_provider.dart';
import 'package:Trebovanje/screens/marketi/marketi_info_screen.dart';
import 'package:provider/provider.dart';

class MarketiItem extends StatelessWidget {
  final MediaQueryData medijakveri;
  final String ime;
  final String logo;
  final String marketId;

  const MarketiItem({
    required this.medijakveri,
    required this.ime,
    required this.logo,
    required this.marketId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(
          context,
          MarketiInfoScreen.routeName,
          arguments: {'marketId': marketId, 'ime': ime, 'logo': logo},
        );
      },
      // onTap: () => Provider.of<Proizvodi>(context, listen: false).addProizvod(
      //   ime: 'Smoki flips sa kikirikijem Soko Štark',
      //   cijena: 1.60,
      //   litara_kg: '225g',
      //   marketId: marketId,
      //   imageUrl: 'https://voli.me/storage/images/products/57349/57349_1.jpg',
      // ),
      child: Container(
        height: (medijakveri.size.height - medijakveri.padding.top) * 0.1,
        // margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: medijakveri.size.width * 0.032),
                // SizedBox(width: 13),
                Text(
                  ime,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
