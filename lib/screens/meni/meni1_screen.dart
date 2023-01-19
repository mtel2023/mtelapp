import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/kartica.dart';
import 'package:mtelapp/components/metode.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:mtelapp/screens/meni/meni2_screen.dart';

import 'package:mtelapp/screens/podesavanja_screen.dart';
import 'package:provider/provider.dart';

class Meni1Screen extends StatefulWidget {
  const Meni1Screen({super.key});

  @override
  State<Meni1Screen> createState() => _Meni1ScreenState();
}

class _Meni1ScreenState extends State<Meni1Screen> {
  bool isInit = true;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (isInit) {
      await Provider.of<Auth>(context).readUserData();
    }

    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1),
      child: Column(
        children: [
          PreferredSize(
            preferredSize: Size(0, 100),
            child: Container(
              child: CustomAppBar(
                funkcija: () {},
                prvaIkonica: Iconsax.home,
                drugaIkonica: Iconsax.shopping_cart,
                pageTitle: 'Meni',
                isBlack: false,
                isChevron: true,
                isCenter: false,
                funkcija2: () {
                  Navigator.of(context).pushNamed(KorpaScreen.routeName);
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08, vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.025),
            child: Column(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(Meni2Screen.routeName),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: medijakveri.size.height * 0.02),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.8),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(medijakveri.size.longestSide * 0.017),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '👋',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                            SizedBox(width: medijakveri.size.width * 0.035),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Zdravo,',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                                Consumer<Auth>(
                                  builder: (context, auth, _) => Container(
                                    width: medijakveri.size.width * 0.4,
                                    height: 35,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${Metode.capitalizeAllWord(auth.getIme!)} ${Metode.capitalizeAllWord(auth.getPrezime!)}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 34,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: medijakveri.size.height * 0.025),
                Kartica(
                  funkcija: () {
                    Navigator.of(context).pushNamed(PodesavanjaScreen.routeName);
                  },
                  ikonica: Iconsax.setting_2,
                  tekst: 'Podešavanja',
                ),
                SizedBox(height: medijakveri.size.height * 0.025),
                Kartica(
                  funkcija: () {},
                  ikonica: Iconsax.document_text_1,
                  tekst: 'Prijavite poslovnicu',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
