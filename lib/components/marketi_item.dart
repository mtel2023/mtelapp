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
      //   'Medenjak od kajsije 150g',
      //   0.89,
      //   'https://voli.me/storage/images/products/14821/14821_1.jpg',
      //   marketId,
      // ),
      child: Container(
        margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 80,
                        width: 110,
                        child: Image.network(
                          logo,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 110,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(.0),
                            Colors.white.withOpacity(1),
                          ],
                          stops: [0.1, 0.9],
                        ),
                      ),
                    )
                  ],
                ),
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
