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
    return Column(
      children: [
        SafeArea(
          child: CustomAppBar(
            funkcija: () {},
            prvaIkonica: Iconsax.home,
            drugaIkonica: Iconsax.shopping_cart,
            pageTitle: 'Meni',
            isBlack: false,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              InkWell(
                onTap: () => prebaciEkran(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '👋',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                          SizedBox(width: 15),
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
                              Text(
                                'Marko Marković',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
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
              SizedBox(height: 30),
              Kartica(
                ikonica: Iconsax.setting_2,
                tekst: 'Podešavanja',
              ),
              SizedBox(height: 25),
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
