// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/customAppbar.dart';

class Meni4Screen extends StatefulWidget {
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
            prvaIkonica: Iconsax.back_square,
            // drugaIkonica: Iconsax.,
            pageTitle: 'Nazad',
            drugaIkonica: Iconsax.tick_circle,
            isBlack: true,
            isChevron: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Trenutna šifra',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: TextField(
                    controller: _oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: '***************'),
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Nova šifra',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: '***************'),
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Potvrdite šifru',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: '***************'),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
