import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/search_bar.dart';

class Marketi2Screen extends StatelessWidget {
  static const String routeName = '/marketi2';
  const Marketi2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
            pageTitle: 'Marketi',
            prvaIkonica: Iconsax.arrow_circle_left,
            prvaIkonicaSize: 34,
            funkcija: () => Navigator.pop(context),
            isBlack: true,
            isChevron: false,
            isCenter: true,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
            child: Column(children: [
              SearchBar('Pretražite market...'),
            ]),
          )
        ],
      )),
    );
  }
}
