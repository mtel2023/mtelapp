import 'package:flutter/material.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/inputField.dart';

class Register2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
              child: Column(
                children: [
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.2),
                  Text(
                    'Dovršite registrciju',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.1),
                  inputField(medijakveri: medijakveri, label: 'Ime', hintText: 'Ime', doneAction: TextInputAction.next, keyboardTip: TextInputType.name, obscureText: false, validator: (value) {}, onSaved: (value) {}),
                  inputField(medijakveri: medijakveri, label: 'Prezime', hintText: 'Prezime', doneAction: TextInputAction.done, keyboardTip: TextInputType.text, obscureText: false, validator: (value) {}, onSaved: (value) {}),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
                  Button(
                    borderRadius: 20,
                    visina: 18,
                    horizontalMargin: 0,
                    buttonText: 'Registrujte se',
                    textColor: Colors.white,
                    isBorder: false,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    funkcija: () {},
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.2),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: Text(
                      'Nazad na početnu',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
