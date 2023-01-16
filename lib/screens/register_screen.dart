import 'package:flutter/material.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/inputField.dart';
import 'package:mtelapp/models/http_exception.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();

  Map<String, String> _authData = {
    'ime': '',
    'prezime': '',
    'email': '',
    'sifra': '',
  };
  final _passwordController = TextEditingController();
  bool isLoading = false;
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

  Future<void> _saveRegister() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false)
          .register(
        _authData['email']!,
        _authData['sifra']!,
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    } on HttpException catch (error) {
      print('madara');
      String emessage = 'Došlo je do greške';
      if (error.toString().contains('EMAIL_EXISTS')) {
        emessage = 'Taj E-mail je već u upotrebi';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        emessage = 'E-mail nije validan';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        emessage = 'Šifra je previše slaba';
      }
      showErrorDialog(emessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _form,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
              child: Column(
                children: [
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.035),
                  Text(
                    'Registrujte se',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.025),
                  inputField(
                      medijakveri: medijakveri,
                      label: 'Ime',
                      hintText: 'Ime',
                      doneAction: TextInputAction.next,
                      keyboardTip: TextInputType.name,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo Vas unesite ime';
                        }
                      },
                      onSaved: (value) {
                        _authData['ime'] = value!;
                      }),
                  inputField(
                      medijakveri: medijakveri,
                      label: 'Prezime',
                      hintText: 'Prezime',
                      doneAction: TextInputAction.next,
                      keyboardTip: TextInputType.text,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo Vas unesite prezime';
                        }
                      },
                      onSaved: (value) {
                        _authData['prezime'] = value!;
                      }),
                  inputField(
                      medijakveri: medijakveri,
                      label: 'Email',
                      hintText: 'E-mail',
                      doneAction: TextInputAction.next,
                      keyboardTip: TextInputType.emailAddress,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo Vas unesite email';
                        }
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      }),
                  Container(
                    margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.005,
                            left: medijakveri.size.width * 0.02,
                          ),
                          child: Text('Šifra'),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Molimo Vas unesite šifru';
                              }
                              if (value.length < 5) {
                                return 'Šifra mora imati više od 4 karaktera';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Šifra',
                              filled: true,
                              fillColor: Colors.white,
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
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.005,
                            left: medijakveri.size.width * 0.02,
                          ),
                          child: Text('Potvrdite šifru'),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Molimo Vas unesite šifru';
                              }
                              if (value != _passwordController.text) {
                                return 'Šifre moraju biti iste';
                              }
                            },
                            onSaved: (value) {
                              _authData['sifra'] = value!;
                            },
                            onFieldSubmitted: (_) {
                              _saveRegister();
                            },
                            decoration: InputDecoration(
                              hintText: 'Šifra',
                              filled: true,
                              fillColor: Colors.white,
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
                      ],
                    ),
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
                  isLoading
                      ? CircularProgressIndicator()
                      : Button(
                          borderRadius: 20,
                          visina: 18,
                          horizontalMargin: 0,
                          buttonText: 'Registrujte se',
                          textColor: Colors.white,
                          isBorder: false,
                          color: Theme.of(context).primaryColor.withOpacity(0.8),
                          funkcija: () {
                            _saveRegister();
                          },
                        ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
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
