import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';

class Meni2Screen extends StatelessWidget {
  const Meni2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SafeArea(
          child: CustomAppBar(
            funkcija: () {
              Navigator.pop(context);
            },
            prvaIkonica: Iconsax.back_square,
            drugaIkonica: Iconsax.edit,
            pageTitle: 'Nazad',
          ),
        ),
      ],
    ));
  }
}
