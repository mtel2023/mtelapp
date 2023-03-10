import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Trebovanje/components/button.dart';
import 'package:Trebovanje/components/inputField.dart';
import 'package:Trebovanje/components/metode.dart';
import 'package:Trebovanje/models/http_exception.dart';
import 'package:Trebovanje/providers/auth_provider.dart';
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
        _authData['ime']!,
        _authData['prezime']!,
        _authData['email']!,
        _authData['sifra']!,
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    } on HttpException catch (error) {
      String emessage = 'Došlo je do greške';
      if (error.toString().contains('EMAIL_EXISTS')) {
        emessage = 'Taj E-mail je već u upotrebi';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        emessage = 'E-mail nije validan';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        emessage = 'Šifra je previše slaba';
      }
      Metode.showErrorDialog(
        message: emessage,
        context: context,
        naslov: 'Greška',
        isButton2: false,
        button1Fun: () {
          Navigator.pop(context);
        },
        button1Text: 'U redu',
      );

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      Metode.showErrorDialog(
        message: 'Došlo je do greške',
        context: context,
        naslov: 'Greška',
        isButton2: false,
        button1Fun: () {
          Navigator.pop(context);
        },
        button1Text: 'U redu',
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  final imeNode = FocusNode();
  final prezimeNode = FocusNode();
  final emailNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pass1Node.addListener(() {
      setState(() {});
    });
    imeNode.addListener(() {
      setState(() {});
    });
    prezimeNode.addListener(() {
      setState(() {});
    });
    emailNode.addListener(() {
      setState(() {});
    });
    pass2Node.addListener(() {
      setState(() {});
    });
  }

  final pass1Node = FocusNode();

  bool isPassHidden = true;
  void changePassVisibility() {
    setState(() {
      isPassHidden = !isPassHidden;
    });
  }

  final pass2Node = FocusNode();

  bool isPassHidden2 = true;
  void changePassVisibility2() {
    setState(() {
      isPassHidden2 = !isPassHidden2;
    });
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
                      focusNode: imeNode,
                      onChanged: (_) => _form.currentState!.validate(),
                      validator: (value) {
                        if (!imeNode.hasFocus) {
                          return null;
                        }
                        if (imeNode.hasFocus) {}

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
                      }),
                  inputField(
                      medijakveri: medijakveri,
                      label: 'Prezime',
                      hintText: 'Prezime',
                      doneAction: TextInputAction.next,
                      keyboardTip: TextInputType.text,
                      obscureText: false,
                      focusNode: prezimeNode,
                      onChanged: (_) => _form.currentState!.validate(),
                      validator: (value) {
                        if (!prezimeNode.hasFocus) {
                          return null;
                        }
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
                      }),
                  inputField(
                    medijakveri: medijakveri,
                    label: 'Email',
                    hintText: 'E-mail',
                    doneAction: TextInputAction.next,
                    keyboardTip: TextInputType.emailAddress,
                    obscureText: false,
                    focusNode: emailNode,
                    onChanged: (_) => _form.currentState!.validate(),
                    validator: (value) {
                      if (!emailNode.hasFocus) {
                        return null;
                      }

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
                            focusNode: pass1Node,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            obscureText: isPassHidden,
                            controller: _passwordController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(pass2Node);
                            },
                            onChanged: (_) => _form.currentState!.validate(),
                            validator: (value) {
                              if (!pass1Node.hasFocus) {
                                return null;
                              }
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
                              suffixIcon: pass1Node.hasFocus
                                  ? IconButton(
                                      onPressed: () => changePassVisibility(),
                                      icon: isPassHidden ? Icon(Iconsax.eye) : Icon(Iconsax.eye_slash),
                                    )
                                  : null,
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
                            focusNode: pass2Node,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: isPassHidden2,
                            onChanged: (_) => _form.currentState!.validate(),
                            validator: (value) {
                              if (!pass2Node.hasFocus) {
                                return null;
                              }

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
                              suffixIcon: pass2Node.hasFocus
                                  ? IconButton(
                                      onPressed: () => changePassVisibility2(),
                                      icon: isPassHidden2 ? Icon(Iconsax.eye) : Icon(Iconsax.eye_slash),
                                    )
                                  : null,
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
                          fontsize: 18,
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pass1Node.dispose();
    pass2Node.dispose();
    imeNode.dispose();
    prezimeNode.dispose();
    emailNode.dispose();
  }
}
