// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Trebovanje/components/customAppbar.dart';
import 'package:Trebovanje/components/inputField.dart';
import 'package:Trebovanje/models/http_exception.dart';
import 'package:Trebovanje/providers/auth_provider.dart';
import 'package:Trebovanje/screens/meni/meni2_screen.dart';
import 'package:provider/provider.dart';

class Meni4Screen extends StatefulWidget {
  static const routeName = '/promijeni-sifru';
  const Meni4Screen({super.key});

  @override
  State<Meni4Screen> createState() => _Meni4ScreenState();
}

class _Meni4ScreenState extends State<Meni4Screen> {
  final _form = GlobalKey<FormState>();

  bool isLoading = false;
  Map<String, String> _data = {
    'trenutnaSifra': '',
    'novaSifra': '',
  };
  final sifraNode = FocusNode();
  final sifra2Node = FocusNode();
  final sifra3Node = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sifraNode.addListener(() {
      setState(() {});
    });
    sifra2Node.addListener(() {
      setState(() {});
    });
    sifra3Node.addListener(() {
      setState(() {});
    });
  }

  bool isPassHidden = true;
  bool isPass2Hidden = true;
  bool isPass3Hidden = true;
  void changePassVisibility() {
    setState(() {
      isPassHidden = !isPassHidden;
    });
  }

  void changePassVisibility2() {
    setState(() {
      isPass2Hidden = !isPass2Hidden;
    });
  }

  void changePassVisibility3() {
    setState(() {
      isPass3Hidden = !isPass3Hidden;
    });
  }

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
  }

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

  final _passwordController = TextEditingController();

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
                  ],
                ),
                Text(
                  'Promijeni šifru',
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
                        onPressed: () {
                          _saveForm();
                        },
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
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
                                child: Text('Trenutna šifra'),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  obscureText: isPassHidden,
                                  focusNode: sifraNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Molimo Vas unesite šifru';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['trenutnaSifra'] = value!;
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(sifra2Node);
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
                                    suffixIcon: sifraNode.hasFocus
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
                      ],
                    )
                  ],
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
                        child: Text('Nova šifra'),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextFormField(
                          focusNode: sifra2Node,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          obscureText: isPass2Hidden,
                          controller: _passwordController,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(sifra3Node);
                          },
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
                            suffixIcon: sifra2Node.hasFocus
                                ? IconButton(
                                    onPressed: () => changePassVisibility2(),
                                    icon: isPass2Hidden ? Icon(Iconsax.eye) : Icon(Iconsax.eye_slash),
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
                          focusNode: sifra3Node,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: isPass3Hidden,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Molimo Vas unesite šifru';
                            }
                            if (value != _passwordController.text) {
                              return 'Šifre moraju biti iste';
                            }
                          },
                          onSaved: (value) {
                            _data['novaSifra'] = value!;
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
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
                            suffixIcon: sifra3Node.hasFocus
                                ? IconButton(
                                    onPressed: () => changePassVisibility3(),
                                    icon: isPass3Hidden ? Icon(Iconsax.eye) : Icon(Iconsax.eye_slash),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    sifraNode.dispose();
    sifra2Node.dispose();
    sifra3Node.dispose();
    _passwordController.dispose();
  }
}
