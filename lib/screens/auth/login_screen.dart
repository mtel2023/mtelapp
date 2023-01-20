import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/allButtons.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/inputField.dart';
import 'package:mtelapp/models/http_exception.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/screens/auth/forgotten_password_screen.dart';
import 'package:mtelapp/screens/auth/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  Map<String, String> _data = {
    'email': '',
    'sifra': '',
  };
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

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false)
          .login(
        _data['email']!,
        _data['sifra']!,
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    } on HttpException catch (error) {
      print(error);
      String emessage = 'Došlo je do greške';
      if (error.toString().contains('INVALID_EMAIL')) {
        emessage = 'E-mail nije validan';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        emessage = 'Ne možemo naći korisnika sa tim E-mailom';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        emessage = 'Netačna šifra';
      }
      showErrorDialog(emessage);
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      showErrorDialog('Došlo je do greške');
      setState(() {
        isLoading = false;
      });
    }
  }

  final focusNode = FocusNode();

  bool isPassHidden = true;
  void changePassVisibility() {
    setState(() {
      isPassHidden = !isPassHidden;
    });
  }

  Widget mojaForma(MediaQueryData medijakveri, context) {
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
                  onChanged: (_) => _form.currentState!.validate(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Molimo Vas da unesete email adresu';
                    }
                  },
                  onSaved: (value) {
                    _data['email'] = value!;
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
                          focusNode: focusNode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: isPassHidden,
                          onChanged: (_) => _form.currentState!.validate(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Molimo Vas unesite šifru';
                            }
                          },
                          onFieldSubmitted: (_) => _saveForm(),
                          onSaved: (value) {
                            _data['sifra'] = value!;
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
                            suffixIcon: focusNode.hasFocus
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
                isLoading
                    ? CircularProgressIndicator()
                    : Button(
                        borderRadius: 20,
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                        textColor: Colors.white,
                        buttonText: 'Prijavite se',
                        fontsize: 18,
                        isBorder: false,
                        funkcija: () => _saveForm(),
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
          onPressed: () => Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName),
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
            ? mojaForma(medijakveri, context)
            : SingleChildScrollView(
                child: mojaForma(medijakveri, context),
              ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }
}
