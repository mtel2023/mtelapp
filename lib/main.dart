import 'package:flutter/material.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/providers/proizvod_provider.dart';
import 'package:mtelapp/screens/bottomNavigation_screen.dart';
import 'package:mtelapp/screens/forgotten_password_screen.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:mtelapp/screens/loginRegister_screen.dart';
import 'package:mtelapp/screens/login_screen.dart';
import 'package:mtelapp/screens/marketi_screen.dart';
import 'package:mtelapp/screens/meni2_screen.dart';
import 'package:mtelapp/screens/meni3_screen.dart';
import 'package:mtelapp/screens/meni4_screen.dart';
import 'package:mtelapp/screens/podesavanja_screen.dart';
import 'package:mtelapp/screens/register_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

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
          title: 'Flutter App',
          home: auth.isAuth ? BottomNavigationScreen() : LoginRegisterScreen(),
          routes: {
            Meni2Screen.routeName: (context) => Meni2Screen(),
            Meni3Screen.routeName: (context) => Meni3Screen(),
            Meni4Screen.routeName: (context) => Meni4Screen(),
            KorpaScreen.routeName: (context) => KorpaScreen(),
            PodesavanjaScreen.routeName: (context) => PodesavanjaScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            ForgottenPasswordScreen.routeName: (context) => ForgottenPasswordScreen(),
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
