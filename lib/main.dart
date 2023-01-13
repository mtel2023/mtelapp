import 'package:flutter/material.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/bottomNavigation_screen.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:mtelapp/screens/meni2_screen.dart';
import 'package:mtelapp/screens/meni3_screen.dart';
import 'package:mtelapp/screens/meni4_screen.dart';
import 'package:mtelapp/screens/podesavanja_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Proizvodi(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(85, 74, 240, 1),
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color.fromRGBO(85, 74, 240, 1), // da bi suffix ikonica (u search baru) promijenila boju kad je focused
              ),
          fontFamily: 'Poppins',
        ),
        title: 'Flutter App',
        home: MyHomePage(),
        routes: {
          Meni2Screen.routeName: (context) => Meni2Screen(),
          Meni3Screen.routeName: (context) => Meni3Screen(),
          Meni4Screen.routeName: (context) => Meni4Screen(),
          KorpaScreen.routeName: (context) => KorpaScreen(),
          PodesavanjaScreen.routeName: (context) => PodesavanjaScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationScreen();
  }
}
