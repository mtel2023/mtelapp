import 'package:flutter/material.dart';

import '../components/allButtons.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                'Prijavite se',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 113,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      inputFile(
                        textlabel: "Email",
                        label: "E-mail",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      inputFile(
                          textlabel: "Šifra",
                          label: "Šifra",
                          controller: _passwordController,
                          obscureText: true),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                          onTap: () {},
                          child: allButtons(
                            ButtonText: 'Prijavi se',
                            backgoundColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            textSize: 18,
                            FontWeight: FontWeight.bold,
                          )),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      InkWell(
                        onTap: () {
                          //_showModal(context);
                        },
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Nazad na login',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Politika privatnosti',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget inputFile(
    {textlabel, obscureText = false, label, keyboardType, controller}) {
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
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 25,
      )
    ],
  );
}
