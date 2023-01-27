import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Trebovanje/components/button.dart';
import 'package:Trebovanje/components/customAppbar.dart';
import 'package:Trebovanje/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class PodesavanjaScreen extends StatefulWidget {
  static const String routeName = '/podesavanja';
  const PodesavanjaScreen({super.key});

  @override
  State<PodesavanjaScreen> createState() => _PodesavanjaScreenState();
}

void _showModal(context, medijakveri) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(
        'Da li ste sigurni da hoćete da se odjavite?',
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              borderRadius: 20,
              visina: 20,
              sirina: 30,
              funkcija: () {
                Navigator.pop(context);
              },
              horizontalMargin: 0,
              buttonText: 'Ne',
              textColor: Colors.black,
              isBorder: true,
            ),
            SizedBox(width: medijakveri.size.width * 0.08),
            Button(
              borderRadius: 20,
              visina: 20,
              sirina: 30,
              funkcija: () {
                Provider.of<Auth>(context, listen: false).logOut();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              horizontalMargin: 0,
              buttonText: 'Da',
              textColor: Colors.white,
              color: Color.fromRGBO(236, 30, 30, 1),
              isBorder: false,
            )
          ],
        )
      ],
    ),
  );
}

class _PodesavanjaScreenState extends State<PodesavanjaScreen> {
  @override
  bool value = false;
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: PreferredSize(
        preferredSize: Size(0, 100),
        child: CustomAppBar(
          funkcija: () {
            Navigator.pop(context);
          },
          prvaIkonica: Iconsax.arrow_circle_left,
          prvaIkonicaSize: 34,
          pageTitle: 'Podešavanja',
          isBlack: true,
          isChevron: false,
          isCenter: true,
          funkcija2: () {},
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
          Container(
            margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
                  child: Text(
                    'Notifikacije',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      inactiveThumbColor: Colors.grey,
                      trackColor: MaterialStateProperty.all<Color>(Color.fromRGBO(217, 217, 217, 1)),
                      value: value,
                      onChanged: (newvalue) {
                        setState(
                          () {
                            value = newvalue;
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => _showModal(context, medijakveri),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07, vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.02),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
                    child: Text(
                      'Odjavite se',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: () {
                        Provider.of<Auth>(context, listen: false).logOut();
                        // Navigator.of(context).pushReplacementNamed('/');
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Iconsax.logout),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
