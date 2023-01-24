import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/screens/auth/login_screen.dart';
import 'package:mtelapp/screens/auth/register_screen.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  height: (medijakveri.size.width - medijakveri.padding.top) * 0.18,
                  margin: EdgeInsets.only(
                    left: medijakveri.size.width * 0.07,
                    // top: (medijakveri.size.width - medijakveri.padding.top) * 0.1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dobrodošli!',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Vrijeme je za uštedu!',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset('assets/icons/saving1.png'),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.02),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/google1.png'),
                        SizedBox(width: 15),
                        FittedBox(
                          child: Text(
                            'Prijava pomoću Googla',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Button(
                    buttonText: 'Registrujte se',
                    textColor: Colors.white,
                    horizontalMargin: medijakveri.size.width * 0.07,
                    color: Theme.of(context).primaryColor.withOpacity(.9),
                    isBorder: false,
                    visina: 16,
                    fontsize: 18,
                    borderRadius: 20,
                    funkcija: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                  ),
                  SizedBox(height: 20),
                  Button(
                    horizontalMargin: medijakveri.size.width * 0.07,
                    borderRadius: 20,
                    visina: 16,
                    fontsize: 18,
                    buttonText: 'Prijavite se',
                    textColor: Colors.black,
                    isBorder: true,
                    funkcija: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Politika privatnosti',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
