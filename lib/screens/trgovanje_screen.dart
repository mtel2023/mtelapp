import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/screens/korpa_screen.dart';

class TrgovanjeScreen extends StatelessWidget {
  const TrgovanjeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: CustomAppBar(
              funkcija: () {},
              prvaIkonica: Iconsax.home,
              drugaIkonica: Iconsax.shopping_cart,
              pageTitle: 'Trgovanje',
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
                SearchBar(hintText: 'Pretražite proizvod...'),
                SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Poslednje trgovanje',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Pogledaj sve',
                        style: TextStyle(
                          color: Color.fromRGBO(85, 74, 240, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
