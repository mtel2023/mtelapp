import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:Trebovanje/components/customAppbar.dart';
import 'package:Trebovanje/components/metode.dart';
import 'package:Trebovanje/providers/orders_provider.dart';
import 'package:provider/provider.dart';

class KupovinaScreen extends StatelessWidget {
  static const String routeName = '/kupovina';
  const KupovinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: PreferredSize(
        preferredSize: Size(0, 100),
        child: CustomAppBar(
          pageTitle: 'Kupovina',
          prvaIkonica: Iconsax.arrow_circle_left,
          prvaIkonicaSize: 34,
          funkcija: () => Navigator.pop(context),
          isBlack: true,
          isChevron: false,
          isCenter: true,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08, vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.015),
        child: Column(
          children: [
            Container(
              height: (medijakveri.size.height - medijakveri.padding.top) * 0.2,
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
                        Text(
                          '${DateFormat('d. MMM y').format(orders.getLoadedOrder.vrijeme)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${orders.getLoadedOrder.proizvodi.length} ${Metode.stavke(orders.getLoadedOrder.proizvodi.length)}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${orders.getLoadedOrder.total.toStringAsFixed(2)}€',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.06),
            Container(
              height: medijakveri.size.height * 0.55,
              child: ListView.builder(
                itemCount: orders.getLoadedOrder.proizvodi.length,
                itemBuilder: (context, i) => Column(
                  children: [
                    Container(
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
                                    '${orders.getLoadedOrder.proizvodi[i].imageUrl}',
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
                                            orders.getLoadedOrder.proizvodi[i].ime.length > 30 ? '${orders.getLoadedOrder.proizvodi[i].ime.substring(0, 30)}...' : orders.getLoadedOrder.proizvodi[i].ime,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      : Container(
                                          constraints: BoxConstraints(maxWidth: 150),
                                          child: Text(
                                            orders.getLoadedOrder.proizvodi[i].ime.length > 15 ? '${orders.getLoadedOrder.proizvodi[i].ime.substring(0, 18)}...' : orders.getLoadedOrder.proizvodi[i].ime,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                  Row(
                                    children: [
                                      Text(
                                        '${orders.getLoadedOrder.proizvodi[i].kolicina} x ',
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                                      ),
                                      Text(
                                        '${orders.getLoadedOrder.proizvodi[i].litara_kg}',
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                                      ),
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
                                Text(
                                  '${orders.getLoadedOrder.proizvodi[i].cijena.toStringAsFixed(2)} €',
                                  style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: medijakveri.size.height * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
