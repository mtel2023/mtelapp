// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/screens/meni/meni2_screen.dart';

class Meni4Screen extends StatefulWidget {
  static const routeName = '/promijeni-sifru';
  const Meni4Screen({super.key});

  @override
  State<Meni4Screen> createState() => _Meni4ScreenState();
}

class _Meni4ScreenState extends State<Meni4Screen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isLoading = false;
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
                        onPressed: () {},
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
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      inputFile(textlabel: "Trenutna šifra", label: "***************", obscureText: true, controller: _oldPasswordController),
                      inputFile(textlabel: "Nova šifra", label: "***************", obscureText: true, controller: _newPasswordController),
                      inputFile(textlabel: "Potvrdite šifru", label: "***************", obscureText: true, controller: _confirmPasswordController),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
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
      SizedBox(
        height: 28,
      )
    ],
  );
}
