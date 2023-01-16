import 'package:flutter/material.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/screens/login_screen.dart';

import '../components/allButtons.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgotten-password';
  final _emailController = TextEditingController();
  _showModal(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 24),
            child: Text(
              'Zahtjev za resetovanje šifre je poslat na unešenu email adresu.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.009),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'U redu',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.23),
                  Text(
                    'Zaboravili ste šifru?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.08),
                  inputFile(
                    textlabel: 'Email',
                    label: 'E-mail',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top) * 0.07),
                  Button(
                    borderRadius: 20,
                    visina: 16,
                    funkcija: () {
                      _showModal(context);
                    },
                    horizontalMargin: 0,
                    buttonText: 'Pošalji zahtjev',
                    textColor: Colors.white,
                    isBorder: false,
                    color: Theme.of(context).primaryColor.withOpacity(.8),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      'Nazad na login',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Politika privatnosti',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputFile({textlabel, obscureText = false, label, keyboardType, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        textlabel,
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(
        height: 6,
      ),
      Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 8,
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: label,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20))),
        ),
      ),
    ],
  );
}
