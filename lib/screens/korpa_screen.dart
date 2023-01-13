import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';

class KorpaScreen extends StatelessWidget {
  static const routeName = '/korpa';
  const KorpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SafeArea(
          child: CustomAppBar(
            pageTitle: 'Korpa',
            prvaIkonica: Iconsax.arrow_circle_left,
            prvaIkonicaSize: 34,
            funkcija: () {
              Navigator.of(context).pop();
            },
            isBlack: true,
            isChevron: false,
            isCenter: true,
          ),
        ),
      ]),
    );
  }
}
