import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/metode.dart';
import 'package:mtelapp/providers/korpa_provider.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  const SearchScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final korpa = Provider.of<Korpa>(context, listen: false);

    final searchText = ModalRoute.of(context)!.settings.arguments;
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
                      '$searchText',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.09),
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
                      '${proizvodi.getSearchItems.length} ${Metode.stavke(proizvodi.getSearchItems.length)}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
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
                                    SizedBox(width: medijakveri.size.width * 0.04),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          proizvodi.getSearchItems[i].ime.length > 15 ? '${proizvodi.getSearchItems[i].ime.substring(0, 18)}...' : proizvodi.getSearchItems[i].ime,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '${proizvodi.getSearchItems[i].cijena} €',
                                          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  padding: EdgeInsets.only(right: 14),
                                  onPressed: () {
                                    korpa.addItem(
                                      proizvodi.getSearchItems[i].id,
                                      proizvodi.getSearchItems[i].cijena,
                                      proizvodi.getSearchItems[i].ime,
                                      proizvodi.getSearchItems[i].imageUrl,
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
                        ),
                        Container(
                          height: (medijakveri.size.height - medijakveri.padding.top) * 0.026,
                        )
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
