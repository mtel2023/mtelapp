import 'package:flutter/material.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/screens/bottomNavigation_screen.dart';
import 'package:mtelapp/screens/meni2_screen.dart';
import 'package:mtelapp/screens/meni4_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(85, 74, 240, 1),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color.fromRGBO(85, 74, 240,
                  1), // da bi suffix ikonica (u search baru) promijenila boju kad je focused
            ),
        fontFamily: 'Poppins',
      ),
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationScreen();
  }
}
