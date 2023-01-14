import 'package:flutter/material.dart';

import '../components/allButtons.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  //const ForgottenPasswordScreen({super.key});
  final _emailController = TextEditingController();
  _showModal(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.009),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 159,
            ),
            Center(
              child: Text(
                'Zaboravili ste šifru?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 113,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 5,
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'E-mail',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                      onTap: () {
                        _showModal(context);
                      },
                      child: allButtons(
                        ButtonText: 'Pošalji zahtjev',
                        backgoundColor: Color.fromRGBO(85, 74, 240, 1),
                        textColor: Colors.white,
                        textSize: 18,
                        FontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      //_showModal(context);
                    },
                    child: allButtons(
                      ButtonText: 'Nazad na login',
                      textColor: Color.fromRGBO(85, 74, 240, 1),
                      textSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 246,
                  ),
                  InkWell(
                      onTap: () {
                        //_showModal(context);
                      },
                      child: allButtons(
                        ButtonText: 'Politika privatnosti',
                        textColor: Color.fromRGBO(85, 74, 240, 1),
                        textSize: 14,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
