import 'package:flutter/material.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/models/order.dart';
import 'package:mtelapp/providers/orders_provider.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/providers/korpa_provider.dart';
import 'package:mtelapp/providers/market_provider.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/auth/forgotten_password_screen.dart';
import 'package:mtelapp/screens/auth/loginRegister_screen.dart';
import 'package:mtelapp/screens/auth/login_screen.dart';
import 'package:mtelapp/screens/auth/register_screen.dart';
import 'package:mtelapp/screens/bottomNavigation_screen.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:mtelapp/screens/kupovina_screen.dart';
import 'package:mtelapp/screens/marketi/marketi_info_screen.dart';
import 'package:mtelapp/screens/marketi/marketi_lista_screen.dart';
import 'package:mtelapp/screens/meni/meni2_screen.dart';
import 'package:mtelapp/screens/meni/meni3_screen.dart';
import 'package:mtelapp/screens/meni/meni4_screen.dart';

import 'package:mtelapp/screens/podesavanja_screen.dart';
import 'package:mtelapp/screens/search_screen.dart';

import 'package:provider/provider.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Proizvodi>(
          update: (ctx, auth, prosliProizvodi) => Proizvodi(auth.token, prosliProizvodi == null ? [] : prosliProizvodi.listaProizvoda),
          create: (ctx) => Proizvodi('', []),
        ),
        ChangeNotifierProxyProvider<Auth, Marketi>(
          update: (ctx, auth, prosliMarketi) => Marketi(auth.token, prosliMarketi == null ? [] : prosliMarketi.listaMarketa),
          create: (ctx) => Marketi('', []),
        ),
        ChangeNotifierProxyProvider<Auth, Korpa>(
          update: (ctx, auth, proslaKorpa) => Korpa(auth.token, proslaKorpa == null ? {} : proslaKorpa.items),
          create: (ctx) => Korpa('', {}),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, prosliOrders) => Orders(auth.token, auth.userId, prosliOrders == null ? [] : prosliOrders.getOrders),
          create: (ctx) => Orders('', '', []),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color.fromRGBO(85, 74, 240, 1),
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Color.fromRGBO(85, 74, 240, 1), // da bi suffix ikonica (u search baru) promijenila boju kad je focused
                ),
            fontFamily: 'Poppins',
          ),
          title: 'Mtel App',
          home: auth.isAuth
              ? BottomNavigationScreen()
              : FutureBuilder(
                  future: auth.autoLogIn(),
                  builder: (context, authResult) => LoginRegisterScreen(),
                ),
          routes: {
            Meni2Screen.routeName: (context) => Meni2Screen(),
            Meni3Screen.routeName: (context) => Meni3Screen(),
            Meni4Screen.routeName: (context) => Meni4Screen(),
            KorpaScreen.routeName: (context) => KorpaScreen(),
            MarketiListaScreen.routeName: (context) => MarketiListaScreen(),
            MarketiInfoScreen.routeName: (context) => MarketiInfoScreen(),
            PodesavanjaScreen.routeName: (context) => PodesavanjaScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            ForgottenPasswordScreen.routeName: (context) => ForgottenPasswordScreen(),
            KupovinaScreen.routeName: (context) => KupovinaScreen(),
          },
        ),
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
