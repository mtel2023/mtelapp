// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomAppBar(
              funkcija: () {
                Navigator.pop(context);
              },
              prvaIkonica: Iconsax.arrow_circle_left,
              prvaIkonicaSize: 34,
              drugaIkonica: Iconsax.tick_circle,
              pageTitle: 'Šifra',
              isBlack: true,
              isChevron: false,
              isCenter: true,
              funkcija2: () {},
            ),
          ),
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
        elevation: 8,
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
