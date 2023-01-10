// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/screens/meni4_screen.dart';

class Meni3Screen extends StatefulWidget {
  static const routeName = '/meni3';
  const Meni3Screen({super.key});

  @override
  State<Meni3Screen> createState() => _Meni3ScreenState();
}

class _Meni3ScreenState extends State<Meni3Screen> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

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
              drugaIkonica: Iconsax.tick_circle,
              pageTitle: 'Nazad',
              isBlack: true,
              isChevron: false,
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
                      inputFile(textlabel: "Ime", label: "Ime", controller: _nameController),
                      inputFile(textlabel: "Prezime", label: "Prezime", controller: _surnameController),
                      inputFile(textlabel: "Email", label: "Email", keyboardType: TextInputType.emailAddress, controller: _emailController),
                      inputFile(textlabel: "Telefon", label: "Telefon", keyboardType: TextInputType.number, controller: _phoneController)
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

Widget inputFile({textlabel, label, keyboardType, controller}) {
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
