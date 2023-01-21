import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/marketi/marketi_info_screen.dart';
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
      //   'Biskvit il gran turchese plus cocoa 300 g Colussi',
      //   0.79,
      //   'https://voli.me/storage/images/products/isler-strawberry-110-g-swisslion-takovo/ecfp-2022-04-15-12-22-28-isleri-jagoda-110g.jpg',
      //   marketId,
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
