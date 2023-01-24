import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mtelapp/components/button.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/kartica.dart';
import 'package:mtelapp/components/metode.dart';
import 'package:mtelapp/components/search_bar.dart';
import 'package:mtelapp/providers/auth_provider.dart';
import 'package:mtelapp/screens/auth/loginRegister_screen.dart';

import 'package:mtelapp/screens/meni/meni3_screen.dart';
import 'package:mtelapp/screens/meni/meni4_screen.dart';

import 'package:provider/provider.dart';

class Meni2Screen extends StatefulWidget {
  static const routeName = '/meni2';
  const Meni2Screen({super.key});

  @override
  State<Meni2Screen> createState() => _Meni2ScreenState();
}

class _Meni2ScreenState extends State<Meni2Screen> {
  Widget meniPolje(String label, String hintText, MediaQueryData medijakveri) {
    return Container(
      margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.01),
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
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.04),
                  child: Text(
                    hintText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    setState(() {
      isLoading = true;
    });
    await Provider.of<Auth>(context).readUserData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
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
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: PreferredSize(
        preferredSize: Size(0, 100),
        child: Container(
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
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Consumer<Auth>(
              builder: (context, auth, _) => Column(
                children: [
                  meniPolje('Ime', '${Metode.capitalizeAllWord(auth.getIme!)}', medijakveri),
                  meniPolje('Prezime', '${Metode.capitalizeAllWord(auth.getPrezime!)}', medijakveri),
                  meniPolje('Email', '${auth.getEmail}', medijakveri),
                  meniPolje('Telefon', ' ${auth.getTelefon}', medijakveri),
                ],
              ),
            ),
            Column(
              children: [
                Button(
                  borderRadius: 20,
                  visina: (medijakveri.size.height - medijakveri.padding.top) * 0.018,
                  funkcija: () => Navigator.of(context).pushNamed(Meni4Screen.routeName),
                  horizontalMargin: 0,
                  buttonText: 'Promijeni šifru',
                  textColor: Colors.black,
                  isBorder: true,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Button(
                  borderRadius: 20,
                  visina: (medijakveri.size.height - medijakveri.padding.top) * 0.018,
                  funkcija: () => _showModal(context),
                  horizontalMargin: 0,
                  buttonText: 'Deaktiviraj',
                  textColor: Colors.white,
                  isBorder: false,
                  color: Color.fromRGBO(236, 30, 30, 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
