import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/providers/market_provider.dart';
import 'package:mtelapp/providers/orders_provider.dart';
import 'package:mtelapp/screens/mape_screen.dart';
import 'package:mtelapp/screens/marketi/marketi1_screen.dart';
import 'package:mtelapp/screens/meni/meni1_screen.dart';
import 'package:mtelapp/screens/trgovanje_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Widget> _pages = [
    Marketi1Screen(),
    MapeScreen(),
    TrgovanjeScreen(),
    MapeScreen(),
    Meni1Screen(),
  ];

  int _selectedIndex = 0;
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
    setState(() {
      isLoading = true;
    });
    Provider.of<Auth>(context).readUserData().then((value) {
      setState(() {
        isInit = false;
      });
    });
    Provider.of<Marketi>(context).readMarkete();
    setState(() {
      isLoading = false;
    });
    Provider.of<Orders>(context).readOrders();
    setState(() {
      isLoading = false;
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 0.3,
              color: Color.fromRGBO(176, 176, 176, 1),
            ),
          ),
        ),
        height: 88,
        child: BottomNavigationBar(
          onTap: _selectPage,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,

          // tabBackgroundColor: Theme.of(context).primaryColor,
          // // backgroundColor: Colors.grey.shade500,
          // activeColor: Colors.white,
          // color: Colors.black,

          // tabBorderRadius: 10,
          // duration: Duration(milliseconds: 500),
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          iconSize: 24,

          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // tabActiveBorder: Border.all(color: Colors.indigo.shade700, width: 1),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Color.fromRGBO(76, 76, 76, 1),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.shop),
              label: 'Marketi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.map_1),
              label: 'Mape',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.wallet_money),
              label: 'Trgovanje',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.status_up),
              label: 'Statistika',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.menu),
              label: 'Meni',
            ),
            // GButton(
            //   icon: Iconsax.shop,
            // ),
            // GButton(
            //   icon: Iconsax.map_1,
            // ),
            // GButton(
            //   icon: Iconsax.wallet_money,
            // ),
            // GButton(
            //   icon: Iconsax.status_up,
            // ),
            // GButton(
            //   icon: Iconsax.menu,
            // ),
          ],
        ),
      ),
    );
  }
}
