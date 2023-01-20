import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/providers/korpa_provider.dart';
import 'package:mtelapp/providers/market_provider.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:provider/provider.dart';

class MarketiInfoScreen extends StatefulWidget {
  static const String routeName = '/marketi_info';

  const MarketiInfoScreen({super.key});

  @override
  State<MarketiInfoScreen> createState() => _MarketiInfoScreenState();
}

class _MarketiInfoScreenState extends State<MarketiInfoScreen> {
  @override
  bool isLoading = false;
  bool isInit = true;
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Proizvodi>(context).readProizvodePoMarketId(args['marketId']!).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final proizvodi = Provider.of<Proizvodi>(context, listen: false);
    final korpa = Provider.of<Korpa>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: PreferredSize(
        preferredSize: Size(0, 100),
        child: CustomAppBar(
          pageTitle: args['ime']!,
          prvaIkonica: Iconsax.arrow_circle_left,
          prvaIkonicaSize: 34,
          funkcija: () => Navigator.pop(context),
          drugaIkonica: Iconsax.shopping_cart,
          funkcija2: () {
            Navigator.of(context).pushNamed(KorpaScreen.routeName);
          },
          isBlack: true,
          isChevron: false,
          isCenter: true,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08),
              child: Column(
                children: [
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
                  Container(
                    height: medijakveri.size.height * 0.177,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        args['logo']!,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${args['ime']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Pogledaj lokacije',
                          style: TextStyle(
                            color: Color.fromRGBO(85, 74, 240, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SearchBar('Pretražite proizvod...'),
                  SizedBox(
                    height: (medijakveri.size.height - medijakveri.padding.top) * 0.025,
                  ),
                  Container(
                    height: (medijakveri.size.height - medijakveri.padding.top) * 0.45,
                    child: ListView.builder(
                      itemCount: proizvodi.listaProizvoda.length,
                      itemBuilder: (ctx, i) => Container(
                        padding: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.015),
                        margin: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.013),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 80,
                                    child: Image.network('${proizvodi.listaProizvoda[i].imageUrl}'),
                                  ),
                                ),
                                SizedBox(width: medijakveri.size.width * 0.04),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      proizvodi.listaProizvoda[i].ime.length > 15 ? '${proizvodi.listaProizvoda[i].ime.substring(0, 18)}...' : proizvodi.listaProizvoda[i].ime,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${proizvodi.listaProizvoda[i].cijena} €',
                                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                // print(proizvodi.listaProizvoda[i].id);
                                korpa.addItem(proizvodi.listaProizvoda[i].id, proizvodi.listaProizvoda[i].cijena, proizvodi.listaProizvoda[i].ime, proizvodi.listaProizvoda[i].imageUrl);
                              },
                              icon: Icon(
                                Iconsax.add_circle,
                                size: 34,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
