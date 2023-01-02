import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/kartica.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/screens/loginRegister_screen.dart';

class Meni2Screen extends StatelessWidget {
  const Meni2Screen({super.key});

  Widget meniPolje(String label, String hintText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    hintText,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
              drugaIkonica: Iconsax.edit,
              pageTitle: 'Nazad',
              isBlack: true,
            ),
          ),
          meniPolje('Ime', 'Marko'),
          meniPolje('Prezime', 'Marković'),
          meniPolje('Email', 'markomarkovic@gmail.com'),
          meniPolje('Telefon', '+382 068 666 666'),
          SizedBox(height: 110),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(27),
            ),
            child: Center(
              child: Text(
                'Promijeni šifru',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginRegisterScreen()), (Route<dynamic> route) => false);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 30, 30),
                borderRadius: BorderRadius.circular(27),
              ),
              child: Center(
                child: Text(
                  'Deaktiviraj',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
