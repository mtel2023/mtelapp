import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/marketi_item.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/main.dart';
import 'package:mtelapp/providers/market_provider.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:mtelapp/screens/marketi/marketi_lista_screen.dart';
import 'package:provider/provider.dart';

class Marketi1Screen extends StatelessWidget {
  const Marketi1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final marketi = Provider.of<Marketi>(context);

    final medijakveri = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(243, 243, 243, 1),
        child: Column(
          children: [
            // custom app bar
            CustomAppBar(
              funkcija: () {
                // Provider.of<Marketi>(context, listen: false).addMarket('Laković', 'https://barinfo.me/wp-content/uploads/2021/06/HDL-LAKOVI%C4%86-logo.jpg', []);
              },
              prvaIkonica: Iconsax.home,
              pageTitle: 'Marketi',
              isBlack: false,
              isChevron: true,
              isCenter: false,
              drugaIkonica: Iconsax.shopping_cart,
              funkcija2: () {
                Navigator.of(context).pushNamed(KorpaScreen.routeName);
              },
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08),
              child: Column(
                children: [
                  // search bar
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.01),

                  SearchBar(hintText: 'Pretražite market...', pretraga: 'market'),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.01),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Marketi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(MarketiListaScreen.routeName);
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

                  Container(
                    height: (medijakveri.size.height - medijakveri.padding.top) * 0.75,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: marketi.listaMarketa.length,
                      itemBuilder: (ctx, i) => Column(
                        children: [
                          SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                          MarketiItem(
                            medijakveri: medijakveri,
                            ime: '${marketi.listaMarketa[i].ime}',
                            logo: '${marketi.listaMarketa[i].logo}',
                            marketId: marketi.listaMarketa[i].id,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
