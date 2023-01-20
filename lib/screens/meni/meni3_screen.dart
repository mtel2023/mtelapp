// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/inputField.dart';
import 'package:mtelapp/components/metode.dart';
import 'package:mtelapp/models/http_exception.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/screens/meni/meni2_screen.dart';

import 'package:provider/provider.dart';

class Meni3Screen extends StatefulWidget {
  static const routeName = '/meni3';
  const Meni3Screen({super.key});

  @override
  State<Meni3Screen> createState() => _Meni3ScreenState();
}

class _Meni3ScreenState extends State<Meni3Screen> {
  final _form = GlobalKey<FormState>();
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      await Provider.of<Auth>(context).readUserData();
      isInit = false;
    }
  }

  Map<String, String> _authData = {
    'ime': '',
    'prezime': '',
    'email': '',
    'telefon': '',
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
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .updateUserData(
        _authData['email']!,
        _authData['ime']!,
        _authData['prezime']!,
        _authData['telefon']!,
      )
          .then((value) {
        Provider.of<Auth>(context, listen: false).readUserData();
        Timer(Duration(milliseconds: 500), () {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        });
      });
    } on HttpException catch (error) {
      print(error);
      String emessage = 'Došlo je do greške';
      if (error.toString().contains('EMAIL_EXISTS')) {
        emessage = 'Taj E-mail je već u upotrebi';
      }
      showErrorDialog(emessage);
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: PreferredSize(
        preferredSize: Size(0, 100),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Iconsax.arrow_circle_left,
                        size: 34,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
                Text(
                  'Uredi profil',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                isLoading
                    ? SizedBox(
                        height: 26,
                        width: 26,
                        child: CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: () => _saveForm(),
                        icon: Icon(
                          Iconsax.tick_circle,
                          size: 34,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer<Auth>(
                      builder: (ctx, auth, _) => Column(
                        children: [
                          inputField(
                            medijakveri: medijakveri,
                            label: 'Ime',
                            initalValue: '${Metode.capitalizeAllWord(auth.getIme!)}',
                            doneAction: TextInputAction.next,
                            keyboardTip: TextInputType.name,
                            obscureText: false,
                            onChanged: (_) => _form.currentState!.validate(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Molimo Vas da unesete ime';
                              }
                              if (value.length < 2) {
                                return 'Ime mora biti duže';
                              }
                              if (value.contains(RegExp(r'[0-9]'))) {
                                return 'Ime smije sadržati samo velika i mala slova';
                              }
                            },
                            onSaved: (value) {
                              _authData['ime'] = value!;
                            },
                          ),
                          inputField(
                            medijakveri: medijakveri,
                            label: 'Prezime',
                            initalValue: '${Metode.capitalizeAllWord(auth.getPrezime!)}',
                            doneAction: TextInputAction.next,
                            keyboardTip: TextInputType.name,
                            obscureText: false,
                            onChanged: (_) => _form.currentState!.validate(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Molimo Vas da unesete prezime';
                              }
                              if (value.length < 2) {
                                return 'Prezime mora biti duže';
                              }
                              if (value.contains(RegExp(r'[0-9]'))) {
                                return 'Prezime smije sadržati samo velika i mala slova';
                              }
                            },
                            onSaved: (value) {
                              _authData['prezime'] = value!;
                            },
                          ),
                          inputField(
                            medijakveri: medijakveri,
                            label: 'Email',
                            initalValue: '${auth.getEmail}',
                            doneAction: TextInputAction.next,
                            keyboardTip: TextInputType.emailAddress,
                            obscureText: false,
                            onChanged: (_) => _form.currentState!.validate(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Molimo Vas da unesete email adresu';
                              }
                              if (!value.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                return 'Molimo Vas unesite validnu email adresu';
                              }
                            },
                            onSaved: (value) {
                              _authData['email'] = value!;
                            },
                          ),
                          inputField(
                            medijakveri: medijakveri,
                            label: 'Telefon',
                            initalValue: '${auth.getTelefon == 'Prazno' ? '' : auth.getTelefon}',
                            doneAction: TextInputAction.done,
                            keyboardTip: TextInputType.phone,
                            obscureText: false,
                            onChanged: (_) => _form.currentState!.validate(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (value.substring(0, 2) != '06') {
                                return 'Molimo Vas unesite validan broj telefona';
                              }
                              if (value.length != 9) {
                                return 'Broj telefona mora sadržati 9 cifara';
                              }
                              if (value.contains(RegExp(r'[^0-9]'))) {
                                return 'Broj telefona smije sadržati samo brojeve';
                              }
                            },
                            onSaved: (value) {
                              _authData['telefon'] = value!;
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
