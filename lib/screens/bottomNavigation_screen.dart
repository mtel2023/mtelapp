import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:Trebovanje/providers/auth_provider.dart';
import 'package:Trebovanje/providers/market_provider.dart';
import 'package:Trebovanje/providers/orders_provider.dart';

import 'package:Trebovanje/screens/marketi/marketi1_screen.dart';
import 'package:Trebovanje/screens/meni/meni1_screen.dart';
import 'package:Trebovanje/screens/statistika_screen.dart';
import 'package:Trebovanje/screens/trgovanje_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Widget> _pages = [
    Marketi1Screen(),
    TrgovanjeScreen(),
    StatistikaScreen(),
    Meni1Screen(),
  ];

  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
          iconSize: 24,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Color.fromRGBO(76, 76, 76, 1),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.shop),
              label: 'Marketi',
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
          ],
        ),
      ),
    );
  }
}
