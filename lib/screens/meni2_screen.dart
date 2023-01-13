import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/kartica.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/screens/loginRegister_screen.dart';
import 'package:mtelapp/screens/meni3_screen.dart';
import 'package:mtelapp/screens/meni4_screen.dart';

class Meni2Screen extends StatelessWidget {
  static const routeName = '/meni2';
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
    _showModal(context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Text(
                  'Da li ste sigurni?',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 66.0, bottom: 66),
              child: Text(
                'Deaktivacijom računa brišu se svi Vaši podaci. Deaktivaciju računa nije moguće opozvati.',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginRegisterScreen()), (Route<dynamic> route) => false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: medijakveri.size.height * 0.020),
                  margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.009),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 30, 30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Deaktiviraj',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020),
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.009),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: (() {
                      Navigator.of(context).pop();
                    }),
                    child: Center(
                      child: Text(
                        'Otkaži',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    }

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
              drugaIkonica: Iconsax.edit,
              pageTitle: 'Profil',
              isBlack: true,
              isChevron: false,
              isCenter: true,
              funkcija2: () {
                Navigator.of(context).pushNamed(Meni3Screen.routeName);
              },
            ),
          ),
          meniPolje('Ime', 'Marko', medijakveri),
          meniPolje('Prezime', 'Marković', medijakveri),
          meniPolje('Email', 'markomarkovic@gmail.com', medijakveri),
          meniPolje('Telefon', '+382 068 666 666', medijakveri),
          SizedBox(height: (medijakveri.size.height - medijakveri.viewPadding.top) * 0.04),
          Container(
            padding: EdgeInsets.symmetric(vertical: medijakveri.size.height * 0.02),
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: (() {
                Navigator.of(context).pushNamed(Meni4Screen.routeName);
              }),
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
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              _showModal(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: medijakveri.size.height * 0.02),
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
