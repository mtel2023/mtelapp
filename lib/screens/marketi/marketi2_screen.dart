import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/marketi_item.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/providers/market_provider.dart';
import 'package:provider/provider.dart';

class Marketi2Screen extends StatefulWidget {
  static const String routeName = '/marketi2';

  const Marketi2Screen({super.key});
  static bool isInit = true;

  @override
  State<Marketi2Screen> createState() => _Marketi2ScreenState();
}

class _Marketi2ScreenState extends State<Marketi2Screen> {
  bool isLoading = false;

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print(Marketi2Screen.isInit);
    if (Marketi2Screen.isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Marketi>(context).readMarkete().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } else {}
    Marketi2Screen.isInit = false;
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
                    SearchBar('Pretražite market...'),
                    SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.025),
                    Container(
                      height: (medijakveri.size.height - medijakveri.padding.top) * 0.75,
                      child: ListView.builder(
                        itemCount: marketi.listaMarketa.length,
                        itemBuilder: (ctx, i) => Column(
                          children: [
                            SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
                            MarketiItem(medijakveri: medijakveri, title: '${marketi.listaMarketa[i].ime}', logo: '${marketi.listaMarketa[i].logo}'),
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
