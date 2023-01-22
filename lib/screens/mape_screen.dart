import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/screens/korpa_screen.dart';

class MapeScreen extends StatelessWidget {
  const MapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: Column(
        children: [
          SafeArea(
            child: CustomAppBar(
              funkcija: () {},
              prvaIkonica: Iconsax.home,
              drugaIkonica: Iconsax.shopping_cart,
              pageTitle: 'Mape',
              isBlack: false,
              isChevron: true,
              isCenter: false,
              funkcija2: () {
                Navigator.of(context).pushNamed(KorpaScreen.routeName);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: SearchBar(
              hintText: 'Pretražite grad...',
              pretraga: 'market',
            ),
          ),
        ],
      ),
    );
  }
}
