import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Trebovanje/components/marketi_item.dart';
import 'package:Trebovanje/components/metode.dart';
import 'package:Trebovanje/components/search_bar.dart';
import 'package:Trebovanje/models/proizvod.dart';
import 'package:Trebovanje/providers/korpa_provider.dart';
import 'package:Trebovanje/providers/market_provider.dart';
import 'package:Trebovanje/providers/proizvod_provider.dart';
import 'package:Trebovanje/screens/korpa_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  // static const String routeName = '/search-screen';
  final String pretraga;
  final String searchText;
  const SearchScreen({required this.pretraga, required this.searchText});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _itemAdded = false;

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

  int _listLength = 0;
  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final korpa = Provider.of<Korpa>(context, listen: false);
    final marketi = Provider.of<Marketi>(context, listen: false);
    marketi.searchAllProducts(widget.searchText).then((list) {
      setState(() {
        _listLength = list.length;
      });
    });
    final proizvodi = Provider.of<Proizvodi>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: Column(
        children: [
          SafeArea(
            child: Container(
              color: Colors.white,
              height: (medijakveri.size.height - medijakveri.padding.top) * 0.07,
              width: medijakveri.size.width,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        proizvodi.clearSearchProizvodi();
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Iconsax.arrow_circle_left,
                        size: 34,
                      ),
                    ),
                    SizedBox(width: medijakveri.size.width * 0.05),
                    Text(
                      '${widget.searchText}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: (medijakveri.size.height - medijakveri.padding.top) * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pronađeno',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.pretraga == 'proizvod'
                          ? '${proizvodi.getSearchItems.length} ${Metode.stavke(proizvodi.getSearchItems.length)}'
                          : widget.pretraga == 'market'
                              ? '${marketi.getSearchMarket.length} ${Metode.stavke(proizvodi.getSearchItems.length)}'
                              : '${_listLength} ${Metode.stavke(_listLength)}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                widget.pretraga == 'proizvod'
                    ? Container(
                        height: (medijakveri.size.height - medijakveri.padding.top) * 0.8,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
                          itemCount: proizvodi.getSearchItems.length,
                          itemBuilder: (ctx, i) => Column(
                            children: [
                              Dismissible(
                                key: ValueKey(proizvodi.getSearchItems[i].id),
                                dismissThresholds: {DismissDirection.startToEnd: 6},
                                direction: DismissDirection.startToEnd,
                                onUpdate: (value) {
                                  if (value.progress < 0.1) {
                                    _itemAdded = false;
                                  }
                                  if (value.progress > 0.8 && !_itemAdded) {
                                    korpa.addItem(
                                      proizvodi.getSearchItems[i].id,
                                      proizvodi.getSearchItems[i].cijena,
                                      proizvodi.getSearchItems[i].ime,
                                      proizvodi.getSearchItems[i].imageUrl,
                                      proizvodi.getSearchItems[i].litara_kg,
                                    );

                                    _itemAdded = true;
                                    showSnackBar();
                                  }
                                },
                                background: Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(255, 12, 223, 65), borderRadius: BorderRadius.circular(20)),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      Iconsax.add_circle,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.015),
                                  // margin: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.013),
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
                                                '${proizvodi.getSearchItems[i].imageUrl}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: medijakveri.size.width * 0.02),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              medijakveri.size.width > 350
                                                  ? Container(
                                                      constraints: BoxConstraints(maxWidth: 175),
                                                      child: Text(
                                                        proizvodi.getSearchItems[i].ime.length > 30 ? '${proizvodi.getSearchItems[i].ime.substring(0, 30)}...' : proizvodi.getSearchItems[i].ime,
                                                        style: TextStyle(fontSize: 16),
                                                      ),
                                                    )
                                                  : Container(
                                                      constraints: BoxConstraints(maxWidth: 150),
                                                      child: Text(
                                                        proizvodi.getSearchItems[i].ime.length > 15 ? '${proizvodi.getSearchItems[i].ime.substring(0, 18)}...' : proizvodi.getSearchItems[i].ime,
                                                        style: TextStyle(fontSize: 16),
                                                      ),
                                                    ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${proizvodi.getSearchItems[i].cijena} €',
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
                                                    '${proizvodi.getSearchItems[i].litara_kg}',
                                                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: medijakveri.size.width * 0.13,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                korpa.addItem(
                                                  proizvodi.getSearchItems[i].id,
                                                  proizvodi.getSearchItems[i].cijena,
                                                  proizvodi.getSearchItems[i].ime,
                                                  proizvodi.getSearchItems[i].imageUrl,
                                                  proizvodi.getSearchItems[i].litara_kg,
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
                    : widget.pretraga == 'allProizvod'
                        ? Container(
                            height: (medijakveri.size.height - medijakveri.padding.top) * 0.8,
                            child: FutureBuilder(
                              future: marketi.searchAllProducts(widget.searchText),
                              builder: (BuildContext context, AsyncSnapshot<List<Proizvod>> snapshot) {
                                if (snapshot.hasData) {
                                  final products = snapshot.data;
                                  return ListView.builder(
                                    itemCount: products!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final product = products[index];
                                      return Column(
                                        children: [
                                          Dismissible(
                                            key: ValueKey(product.id),
                                            dismissThresholds: {DismissDirection.startToEnd: 6},
                                            direction: DismissDirection.startToEnd,
                                            onUpdate: (value) {
                                              if (value.progress < 0.1) {
                                                _itemAdded = false;
                                              }
                                              if (value.progress > 0.8 && !_itemAdded) {
                                                korpa.addItem(
                                                  product.id,
                                                  product.cijena,
                                                  product.ime,
                                                  product.imageUrl,
                                                  product.litara_kg,
                                                );

                                                _itemAdded = true;
                                                showSnackBar();
                                              }
                                            },
                                            background: Container(
                                              decoration: BoxDecoration(color: Color.fromARGB(255, 12, 223, 65), borderRadius: BorderRadius.circular(20)),
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Icon(
                                                  Iconsax.add_circle,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.015),
                                              // margin: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.013),
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
                                                            '${product.imageUrl}',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: medijakveri.size.width * 0.02),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          medijakveri.size.width > 350
                                                              ? Container(
                                                                  constraints: BoxConstraints(maxWidth: 175),
                                                                  child: Text(
                                                                    product.ime.length > 30 ? '${product.ime.substring(0, 30)}...' : product.ime,
                                                                    style: TextStyle(fontSize: 16),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  constraints: BoxConstraints(maxWidth: 150),
                                                                  child: Text(
                                                                    product.ime.length > 15 ? '${product.ime.substring(0, 18)}...' : product.ime,
                                                                    style: TextStyle(fontSize: 16),
                                                                  ),
                                                                ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${product.cijena.toStringAsFixed(2)} €',
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
                                                                '${product.litara_kg}',
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
                                                    width: medijakveri.size.width * 0.13,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.keyboard_arrow_right_outlined,
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
                                          SizedBox(height: 20),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          )
                        : Container(
                            height: (medijakveri.size.height - medijakveri.padding.top) * 0.8,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: marketi.getSearchMarket.length,
                              itemBuilder: (ctx, i) => Column(
                                children: [
                                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                                  MarketiItem(
                                    medijakveri: medijakveri,
                                    ime: '${marketi.getSearchMarket[i].ime}',
                                    logo: '${marketi.getSearchMarket[i].logo}',
                                    marketId: marketi.getSearchMarket[i].id,
                                  ),
                                ],
                              ),
                            ),
                          ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
