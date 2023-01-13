import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/screens/korpa_screen.dart';

class MapeScreen extends StatelessWidget {
  const MapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: CustomAppBar(
            funkcija: () {},
            prvaIkonica: Iconsax.home,
            drugaIkonica: Iconsax.shopping_cart,
            pageTitle: 'Mape',
            isBlack: false,
            isChevron: true,
            funkcija2: () {
              Navigator.of(context).pushNamed(KorpaScreen.routeName);
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: SearchBar(hintText: 'Pretražite grad...'),
        ),
      ],
    );
  }
}
