import 'package:flutter/material.dart';
import 'package:mtelapp/components/allButtons.dart';
import 'package:mtelapp/components/inputField.dart';
import 'package:mtelapp/models/http_exception.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/screens/forgotten_password_screen.dart';
import 'package:mtelapp/screens/register_screen.dart';
import 'package:provider/provider.dart';
import '../components/button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  Map<String, String> _data = {
    'email': '',
    'sifra': '',
  };

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Text(
            'Greška',
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 24),
            child: Text(
              message,
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
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

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(
        _data['email']!,
        _data['sifra']!,
      )
          .then((value) {
        Navigator.of(context).pop();
      });
      ;
    } on HttpException catch (error) {
      String emessage = 'Došlo je do greške';
      if (error.toString().contains('INVALID_EMAIL')) {
        emessage = 'E-mail nije validan';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        emessage = 'Ne možemo naći korisnika sa tim E-mailom';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        emessage = 'Netačna šifra';
      }
      showErrorDialog(emessage);
    }
  }

  Widget MojaForma(MediaQueryData medijakveri, context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: medijakveri.size.height * 0.01),
        Text(
          'Prijavite se',
          style: TextStyle(
            fontSize: medijakveri.size.height * 0.035,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
          child: Form(
            key: _form,
            child: Column(
              children: [
                inputField(
                  medijakveri: medijakveri,
                  label: 'Email',
                  hintText: 'E-mail',
                  doneAction: TextInputAction.next,
                  keyboardTip: TextInputType.emailAddress,
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Molimo Vas unesite E-mail';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Molimo Vas unesite validan E-mail';
                    }
                  },
                  onSaved: (value) {
                    _data['email'] = value!;
                  },
                ),
                inputField(
                  medijakveri: medijakveri,
                  label: 'Šifra',
                  hintText: 'Šifra',
                  doneAction: TextInputAction.done,
                  keyboardTip: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Molimo Vas unesite šifru';
                    }
                  },
                  onSaved: (value) {
                    _data['sifra'] = value!;
                  },
                ),
                Button(
                  borderRadius: 20,
                  color: Theme.of(context).primaryColor.withOpacity(.8),
                  textColor: Colors.white,
                  buttonText: 'Prijavite se',
                  isBorder: false,
                  funkcija: () {
                    _saveForm();
                  },
                  visina: 18,
                  horizontalMargin: 0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ForgottenPasswordScreen.routeName);
                  },
                  child: Text('Zaboravili ste šifru?'),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
          },
          child: Text('Nemate račun?'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: SafeArea(
        child: (medijakveri.size.height > 650)
            ? MojaForma(medijakveri, context)
            : SingleChildScrollView(
                child: MojaForma(medijakveri, context),
              ),
      ),
    );
  }
}
