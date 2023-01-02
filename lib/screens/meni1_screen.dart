import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/kartica.dart';
import 'package:mtelapp/screens/meni2_screen.dart';

class Meni1Screen extends StatelessWidget {
  const Meni1Screen({super.key});

  void prebaciEkran(ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Meni2Screen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Column(
      children: [
        SafeArea(
          child: CustomAppBar(
            funkcija: () {},
            prvaIkonica: Iconsax.home,
            drugaIkonica: Iconsax.shopping_cart,
            pageTitle: 'Meni',
            isBlack: false,
            isChevron: true,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
          child: Column(
            children: [
              InkWell(
                onTap: () => prebaciEkran(context),
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
                            // padding: EdgeInsets.all(15),
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
                              Container(
                                width: medijakveri.size.width * 0.4,
                                height: 35,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Marko Marković',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
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
                ikonica: Iconsax.setting_2,
                tekst: 'Podešavanja',
              ),
              SizedBox(height: medijakveri.size.height * 0.025),
              Kartica(
                ikonica: Iconsax.document_text_1,
                tekst: 'Prijavite poslovnicu',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
