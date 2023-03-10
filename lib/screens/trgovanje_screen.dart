import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:Trebovanje/components/customAppbar.dart';
import 'package:Trebovanje/components/metode.dart';
import 'package:Trebovanje/components/search_bar.dart';
import 'package:Trebovanje/providers/market_provider.dart';
import 'package:Trebovanje/providers/orders_provider.dart';
import 'package:Trebovanje/screens/korpa_screen.dart';
import 'package:Trebovanje/screens/kupovina_screen.dart';
import 'package:provider/provider.dart';

class TrgovanjeScreen extends StatefulWidget {
  const TrgovanjeScreen({super.key});

  @override
  State<TrgovanjeScreen> createState() => _TrgovanjeScreenState();
}

class _TrgovanjeScreenState extends State<TrgovanjeScreen> {
  bool isInit = true;
  bool isLoading = true;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (isInit) {
      await Provider.of<Orders>(context, listen: false).readOrders().then((value) {
        isInit = false;
        Timer(Duration(milliseconds: 200), () {
          setState(() {
            isLoading = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final orders = Provider.of<Orders>(context);

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Color.fromRGBO(243, 243, 243, 1),
            height: (medijakveri.size.height - medijakveri.padding.top),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: CustomAppBar(
                      funkcija: () {},
                      prvaIkonica: Iconsax.home,
                      drugaIkonica: Iconsax.shopping_cart,
                      pageTitle: 'Trgovanje',
                      isBlack: false,
                      isChevron: true,
                      isCenter: false,
                      funkcija2: () {
                        Navigator.of(context).pushNamed(KorpaScreen.routeName);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08),
                    child: Column(
                      children: [
                        SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.01),
                        SearchBar(
                          hintText: 'Pretra??ite proizvod...',
                          pretraga: 'allProizvod',
                        ),
                        SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trgovanja',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Pogledaj sve',
                                style: TextStyle(
                                  color: Color.fromRGBO(85, 74, 240, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: (medijakveri.size.height - medijakveri.padding.top) * 0.01,
                        ),
                        orders.getOrders.length == 0
                            ? Container(
                                height: (medijakveri.size.height - medijakveri.padding.top) * 0.4,
                                child: Center(
                                  child: Text(
                                    'Nemate sa??uvanih kupovina',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  orders.readOrderById(orders.lastOrder.id);
                                  Navigator.pushNamed(context, KupovinaScreen.routeName);
                                },
                                child: Container(
                                  height: (medijakveri.size.height - medijakveri.padding.top) * 0.23,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Theme.of(context).primaryColor.withOpacity(.7),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.06),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Poslednje trgovanje',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '${orders.lastOrder.proizvodi.length} ${Metode.stavke(orders.lastOrder.proizvodi.length)}',
                                                  style: TextStyle(
                                                    color: Colors.white.withOpacity(.7),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Iconsax.money_send,
                                              color: Colors.white,
                                              size: 34,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${orders.lastOrder.total.toStringAsFixed(2)}???',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 34,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        Container(
                          height: (medijakveri.size.height - medijakveri.padding.top) * 0.4,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                              vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.03,
                            ),
                            itemCount: orders.getOrders.length == 0 ? orders.getOrders.length : orders.getOrders.length - 1,
                            itemBuilder: ((context, i) => InkWell(
                                  onTap: () {
                                    orders.readOrderById(orders.getOrders[i < orders.getOrders.length ? i + 1 : i].id);
                                    Navigator.pushNamed(context, KupovinaScreen.routeName);
                                  },
                                  child: Container(
                                    height: (medijakveri.size.height - medijakveri.padding.top) * 0.1,
                                    margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.03),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Iconsax.dollar_circle,
                                                size: 43,
                                              ),
                                              SizedBox(width: medijakveri.size.width * 0.05),
                                              Container(
                                                height: (medijakveri.size.height - medijakveri.padding.top) * 0.053,
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${DateFormat('d. MMM y').format(orders.getOrders[i < orders.getOrders.length ? i + 1 : i].vrijeme)}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${orders.getOrders[i < orders.getOrders.length ? i + 1 : i].proizvodi.length} ${Metode.stavke(orders.getOrders[i < orders.getOrders.length ? i + 1 : i].proizvodi.length)}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey.withOpacity(0.7),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${orders.getOrders[i < orders.getOrders.length ? i + 1 : i].total.toStringAsFixed(2)}???',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
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
