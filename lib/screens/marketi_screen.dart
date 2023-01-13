import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/main.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:provider/provider.dart';

class MarketiScreen extends StatelessWidget {
  const MarketiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // custom app bar
          SafeArea(
            child: CustomAppBar(
              funkcija: () {},
              prvaIkonica: Iconsax.home,
              drugaIkonica: Iconsax.shopping_cart,
              pageTitle: 'Marketi',
              isBlack: false,
              isChevron: true,
              isCenter: false,
              funkcija2: () {
                Navigator.of(context).pushNamed(KorpaScreen.routeName);
              },
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
            child: Column(
              children: [
                // search bar
                SearchBar(hintText: 'Pretražite market...'),
                SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Marketi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Proizvodi>(context, listen: false).addProizvod('Smoki flips sa kikirikijem 225 g Soko Štark', 1.69, 'https://voli.me/storage/images/products/57349/57349_1.jpg');
                      },
                      child: Text(
                        'Pogledaj sve',
                        style: TextStyle(
                          color: Color.fromRGBO(85, 74, 240, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/icons/Voli.png'),
                Image.asset('assets/icons/Franca.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
