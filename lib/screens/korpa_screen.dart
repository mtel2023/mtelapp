import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/metode.dart';
import 'package:mtelapp/providers/orders_provider.dart';
import 'package:mtelapp/models/proizvod.dart';
import 'package:mtelapp/providers/korpa_provider.dart';
import 'package:mtelapp/providers/market_provider.dart';
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
  bool isLoading = false;

  Future<void> dodaj() async {
    final orders = Provider.of<Orders>(context, listen: false);
    final korpa = Provider.of<Korpa>(context, listen: false);

    try {
      setState(() {
        isLoading = true;
      });
      await orders.addOrder(korpa.total, korpa.items.values.toList()).then((value) {
        setState(() {
          isLoading = false;
        });
        korpa.clear();
      });
    } on HttpException catch (error) {
      String emessage = 'Došlo je do greške';

      Metode.showErrorDialog(
        message: emessage,
        context: context,
        naslov: 'Greška',
        isButton2: false,
        button1Fun: () {
          Navigator.pop(context);
        },
        button1Text: 'U redu',
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      Metode.showErrorDialog(
        message: 'Došlo je do greške',
        context: context,
        naslov: 'Greška',
        isButton2: false,
        button1Fun: () {
          Navigator.pop(context);
        },
        button1Text: 'U redu',
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void showErrorDialog({button1Fun, button2Fun}) {
    showDialog(
      context: context,
      builder: (context) {
        final medijakveri = MediaQuery.of(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Text(
            'Da li ste sigurni da želite da uklonite stavku iz korpe?',
            style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  borderRadius: 20,
                  visina: medijakveri.size.height * 0.016,
                  sirina: medijakveri.size.width * 0.07,
                  funkcija: () => button1Fun(),
                  horizontalMargin: 0,
                  fontsize: 16,
                  buttonText: 'Otkaži',
                  textColor: Colors.black,
                  isBorder: true,
                  color: Colors.white,
                ),
                SizedBox(width: medijakveri.size.width * 0.03),
                Button(
                  borderRadius: 20,
                  visina: medijakveri.size.height * 0.016,
                  sirina: medijakveri.size.width * 0.07,
                  funkcija: () => button2Fun!(),
                  horizontalMargin: 0,
                  fontsize: 16,
                  buttonText: 'Ukloni',
                  textColor: Colors.white,
                  isBorder: false,
                  color: Color.fromARGB(255, 255, 17, 0),
                )
              ],
            ),
            SizedBox(
              height: medijakveri.size.height * 0.01,
              // height: 20,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final korpa = Provider.of<Korpa>(context);
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
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              isBlack: true,
              isChevron: false,
              isCenter: true,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
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
                        '${korpa.items.length} ${Metode.stavke(korpa.items.length)}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.013),
                isLoading
                    ? Container(
                        height: (medijakveri.size.height - medijakveri.padding.top) * 0.6,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : korpa.items.length == 0
                        ? Container(
                            height: (medijakveri.size.height - medijakveri.padding.top) * 0.6,
                            child: Center(
                              child: Text(
                                'Prazno',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: (medijakveri.size.height - medijakveri.padding.top) * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: (medijakveri.size.height - medijakveri.padding.top) * 0.001),
                              itemCount: korpa.items.length,
                              itemBuilder: (context, i) => Column(
                                children: [
                                  Dismissible(
                                    key: ValueKey(korpa.items.values.toList()[i].id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      korpa.deleteItem(korpa.items.values.toList()[i].id);
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          elevation: 4,
                                          dismissDirection: DismissDirection.none,
                                          margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.225),
                                          backgroundColor: Colors.white,
                                          content: Text(
                                            'Stavka uklonjena iz korpe!',
                                            style: TextStyle(color: Theme.of(context).primaryColor),
                                          ),
                                          action: SnackBarAction(
                                            label: 'Vrati',
                                            textColor: Theme.of(context).primaryColor,
                                            onPressed: () {
                                              korpa.restore(korpa.getDeletedItem);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    background: Container(
                                      decoration: BoxDecoration(color: Color.fromRGBO(236, 30, 30, 1), borderRadius: BorderRadius.circular(20)),
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Icon(
                                          Iconsax.trash,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: (medijakveri.size.height - medijakveri.padding.top) * 0.13,
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
                                                    korpa.items.values.toList()[i].imageUrl,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: medijakveri.size.height * 0.11,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    medijakveri.size.width > 350
                                                        ? Container(
                                                            // color: Colors.black.withOpacity(.3),
                                                            constraints: BoxConstraints(maxWidth: 175),
                                                            // width: 190,
                                                            child: Text(
                                                              korpa.items.values.toList()[i].ime.length > 30 ? '${korpa.items.values.toList()[i].ime.substring(0, 30)}...' : korpa.items.values.toList()[i].ime,
                                                              style: TextStyle(fontSize: 16),
                                                            ),
                                                          )
                                                        : Container(
                                                            constraints: BoxConstraints(maxWidth: 150),
                                                            child: Text(
                                                              korpa.items.values.toList()[i].ime.length > 15 ? '${korpa.items.values.toList()[i].ime.substring(0, 18)}...' : korpa.items.values.toList()[i].ime,
                                                              style: TextStyle(fontSize: 16),
                                                            ),
                                                          ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${korpa.items.values.toList()[i].cijena} €',
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
                                                          '${korpa.items.values.toList()[i].litara_kg}',
                                                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: (medijakveri.size.height - medijakveri.padding.top) * 0.09,
                                            margin: EdgeInsets.only(right: medijakveri.size.width * 0.03),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(243, 243, 243, 1),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    korpa.addItem(korpa.items.values.toList()[i].id, korpa.items.values.toList()[i].cijena, korpa.items.values.toList()[i].ime, korpa.items.values.toList()[i].imageUrl, korpa.items.values.toList()[i].litara_kg);
                                                  },
                                                  child: Icon(Iconsax.add),
                                                ),
                                                Text(
                                                  '${korpa.items.values.toList()[i].kolicina}',
                                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (korpa.items.values.toList()[i].kolicina > 1) {
                                                      korpa.smanjiKolicinu(korpa.items.values.toList()[i].id);
                                                    } else {
                                                      showErrorDialog(
                                                        button1Fun: () {
                                                          Navigator.pop(context);
                                                        },
                                                        button2Fun: () {
                                                          korpa.deleteItem(korpa.items.values.toList()[i].id);
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Icon(
                                                    Iconsax.minus,
                                                    color: korpa.items.values.toList()[i].kolicina == 1 ? Colors.red : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.026),
                                ],
                              ),
                            ),
                          ),
              ],
            ),
          ),
          Container(
            height: ((medijakveri.size.height - medijakveri.padding.top) * 0.225),
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
                            '${korpa.total.toStringAsFixed(2)}€',
                            style: TextStyle(
                              fontSize: 28,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${korpa.items.length} ${Metode.stavke(korpa.items.length)}',
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
                  isLoading
                      ? CircularProgressIndicator()
                      : Button(
                          borderRadius: 20,
                          visina: (medijakveri.size.height - medijakveri.padding.top) * 0.018,
                          funkcija: () {
                            dodaj();
                          },
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
