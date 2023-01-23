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
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    if (isInit) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Proizvodi>(context).readProizvodePoMarketId(args['marketId']!).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        dismissDirection: DismissDirection.none,
        backgroundColor: Colors.white,
        content: Text(
          'Stavka dodana u korpu!',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        action: SnackBarAction(
          label: 'Pogledaj',
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pushNamed(KorpaScreen.routeName);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final proizvodi = Provider.of<Proizvodi>(context, listen: false);
    final korpa = Provider.of<Korpa>(context, listen: false);
    bool _itemAdded = false;
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
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            Navigator.of(context).pushNamed(KorpaScreen.routeName);
          },
          isBlack: true,
          isChevron: false,
          isCenter: true,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
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
                    SearchBar(
                      hintText: 'Pretražite proizvod...',
                      pretraga: 'proizvod',
                    ),
                    SizedBox(
                      height: (medijakveri.size.height - medijakveri.padding.top) * 0.025,
                    ),
                    Container(
                      height: (medijakveri.size.height - medijakveri.padding.top) * 0.45,
                      child: ListView.builder(
                        itemCount: proizvodi.listaProizvoda.length,
                        itemBuilder: (ctx, i) => Column(
                          children: [
                            Dismissible(
                              key: ValueKey(proizvodi.listaProizvoda[i].id),
                              dismissThresholds: {DismissDirection.startToEnd: 6},
                              direction: DismissDirection.startToEnd,
                              onUpdate: (value) {
                                if (value.progress < 0.1) {
                                  _itemAdded = false;
                                }
                                if (value.progress > 0.45 && !_itemAdded) {
                                  korpa.addItem(
                                    proizvodi.listaProizvoda[i].id,
                                    proizvodi.listaProizvoda[i].cijena,
                                    proizvodi.listaProizvoda[i].ime,
                                    proizvodi.listaProizvoda[i].imageUrl,
                                    proizvodi.listaProizvoda[i].litara_kg,
                                  );

                                  _itemAdded = true;
                                  showSnackBar();
                                }
                              },
                              background: Container(
                                decoration: BoxDecoration(color: Color.fromARGB(255, 12, 223, 65), borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(
                                    Iconsax.add_circle,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.015),
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
                                            width: 80,
                                            child: Image.network(
                                              '${proizvodi.listaProizvoda[i].imageUrl}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: medijakveri.size.width * 0.01),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            medijakveri.size.width > 350
                                                ? Container(
                                                    constraints: BoxConstraints(maxWidth: 175),
                                                    child: Text(
                                                      proizvodi.listaProizvoda[i].ime.length > 30 ? '${proizvodi.listaProizvoda[i].ime.substring(0, 30)}...' : proizvodi.listaProizvoda[i].ime,
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                  )
                                                : Container(
                                                    constraints: BoxConstraints(maxWidth: 150),
                                                    child: Text(
                                                      proizvodi.listaProizvoda[i].ime.length > 15 ? '${proizvodi.listaProizvoda[i].ime.substring(0, 18)}...' : proizvodi.listaProizvoda[i].ime,
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                  ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${proizvodi.listaProizvoda[i].cijena} €',
                                                  style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                                                ),
                                                // SizedBox(width: 10),
                                                Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                                  height: 20,
                                                  width: 1,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  '${proizvodi.listaProizvoda[i].litara_kg}',
                                                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      // color: Colors.black,
                                      width: medijakveri.size.width * 0.15,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            // padding: EdgeInsets.only(right: medijakveri.size.width * 0.03),
                                            onPressed: () {
                                              korpa.addItem(
                                                proizvodi.listaProizvoda[i].id,
                                                proizvodi.listaProizvoda[i].cijena,
                                                proizvodi.listaProizvoda[i].ime,
                                                proizvodi.listaProizvoda[i].imageUrl,
                                                proizvodi.listaProizvoda[i].litara_kg,
                                              );

                                              showSnackBar();
                                            },
                                            icon: Icon(
                                              Iconsax.add_circle,
                                              size: 34,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: (medijakveri.size.height - medijakveri.padding.top) * 0.026,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
