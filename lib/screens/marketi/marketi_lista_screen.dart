import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Trebovanje/components/customAppbar.dart';
import 'package:Trebovanje/components/marketi_item.dart';
import 'package:Trebovanje/components/search_bar.dart';
import 'package:Trebovanje/providers/market_provider.dart';
import 'package:Trebovanje/screens/korpa_screen.dart';
import 'package:provider/provider.dart';

class MarketiListaScreen extends StatefulWidget {
  static const String routeName = '/marketi2';

  const MarketiListaScreen({super.key});

  @override
  State<MarketiListaScreen> createState() => _MarketiListaScreenState();
}

class _MarketiListaScreenState extends State<MarketiListaScreen> {
  bool isLoading = false;
  bool isInit = true;
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Marketi>(context).readMarkete().then((value) {
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
    final marketi = Provider.of<Marketi>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: PreferredSize(
        preferredSize: Size(0, 100),
        child: CustomAppBar(
          pageTitle: 'Marketi',
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
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.025),
                    SearchBar(
                      hintText: 'Pretražite market...',
                      pretraga: 'market',
                    ),
                    Container(
                      height: (medijakveri.size.height - medijakveri.padding.top) * 0.75,
                      child: ListView.builder(
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
            ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<Marketi>(context, listen: false).dispose();
  }
}
