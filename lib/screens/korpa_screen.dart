import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/models/proizvod.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:provider/provider.dart';

class KorpaScreen extends StatefulWidget {
  static const routeName = '/korpa';
  const KorpaScreen({super.key});

  @override
  State<KorpaScreen> createState() => _KorpaScreenState();
}

class _KorpaScreenState extends State<KorpaScreen> {
  @override
  bool isInit = true;
  bool isLoading = false;
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Proizvodi>(context).readProizvode().then((value) {
        isLoading = false;

        print('hashriama');
      });
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final proizvodi = Provider.of<Proizvodi>(context);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomAppBar(
              pageTitle: 'Korpa',
              prvaIkonica: Iconsax.arrow_circle_left,
              prvaIkonicaSize: 34,
              funkcija: () {
                Navigator.of(context).pop();
              },
              isBlack: true,
              isChevron: false,
              isCenter: true,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Market Voli',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${proizvodi.listaProizvoda.length} stavke',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        height: (medijakveri.size.height - medijakveri.padding.top) * 0.55,
                        child: ListView.builder(
                          itemCount: proizvodi.listaProizvoda.length,
                          itemBuilder: (context, i) => Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 90,
                                      child: Image.network(
                                        proizvodi.listaProizvoda[i].imageUrl,
                                      ),
                                    ),
                                    SizedBox(width: medijakveri.size.width * 0.01),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          proizvodi.listaProizvoda[i].ime.length > 20 ? '${proizvodi.listaProizvoda[i].ime.substring(0, 21)}...' : proizvodi.listaProizvoda[i].ime,
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
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(Iconsax.add),
                                    ),
                                    Text('1'),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(Iconsax.minus),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ukupno',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '5.69€',
                          style: TextStyle(fontSize: 28, color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          '${proizvodi.listaProizvoda.length} stavke',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.05),
                Container(
                  padding: EdgeInsets.symmetric(vertical: medijakveri.size.height * 0.02),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(27)),
                  child: Center(
                    child: Text(
                      'Sačuvaj kupovinu',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
