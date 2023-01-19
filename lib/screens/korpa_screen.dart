import 'dart:async';
import 'dart:io';

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
    final proizvodi = Provider.of<Proizvodi>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
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
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.09),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Market Voli',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${proizvodi.listaProizvoda.length} stavke',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        height: (medijakveri.size.height - medijakveri.padding.top) * 0.62,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: (medijakveri.size.height - medijakveri.padding.top) * 0.001),
                          itemCount: proizvodi.listaProizvoda.length,
                          itemBuilder: (context, i) => Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                            height: (medijakveri.size.height - medijakveri.padding.top) * 0.13,
                            margin: EdgeInsets.symmetric(vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.013),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          proizvodi.listaProizvoda[i].imageUrl,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: medijakveri.size.width * 0.02),
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
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.09),
              child: Column(
                children: [
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ukupno',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '5.69€',
                            style: TextStyle(
                              fontSize: 28,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${proizvodi.listaProizvoda.length} stavke',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.01),
                  Button(
                    borderRadius: 20,
                    visina: (medijakveri.size.height - medijakveri.padding.top) * 0.018,
                    funkcija: () {},
                    horizontalMargin: 0,
                    buttonText: 'Sačuvaj kupovinu',
                    textColor: Colors.white,
                    isBorder: false,
                    color: Theme.of(context).primaryColor.withOpacity(.8),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
