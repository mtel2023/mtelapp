import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/kartica.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/screens/loginRegister_screen.dart';

class Meni2Screen extends StatelessWidget {
  const Meni2Screen({super.key});

  Widget meniPolje(String label, String hintText, MediaQueryData medijakveri) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: medijakveri.size.width * 0.01, bottom: medijakveri.size.height * 0.01),
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
            margin: EdgeInsets.only(bottom: medijakveri.size.height * 0.019),
            height: medijakveri.size.height * 0.066,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: medijakveri.size.width * 0.001,
                  blurRadius: 4,
                  offset: Offset(0, medijakveri.size.height * 0.005), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.04),
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
    final medijakveri = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomAppBar(
              funkcija: () {
                Navigator.pop(context);
              },
              prvaIkonica: Iconsax.arrow_circle_left,
              drugaIkonica: Iconsax.edit,
              pageTitle: 'Nazad',
              isBlack: true,
              isChevron: false,
            ),
          ),
          meniPolje('Ime', 'Marko', medijakveri),
          meniPolje('Prezime', 'Marković', medijakveri),
          meniPolje('Email', 'markomarkovic@gmail.com', medijakveri),
          meniPolje('Telefon', '+382 068 666 666', medijakveri),
          SizedBox(height: medijakveri.size.height * 0.07),
          Container(
            padding: EdgeInsets.symmetric(vertical: medijakveri.size.height * 0.023),
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(20),
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
              padding: EdgeInsets.symmetric(vertical: medijakveri.size.height * 0.023),
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 30, 30),
                borderRadius: BorderRadius.circular(20),
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
