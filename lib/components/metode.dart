import 'package:flutter/material.dart';

class Metode {
  static String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  static void showErrorDialog({required String message, required BuildContext context, required String naslov, required String button1Text, String? button2Text, required Function button1Fun, Function? button2Fun, required bool isButton2}) {
    showDialog(
      context: context,
      builder: (context) {
        final medijakveri = MediaQuery.of(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Text(
            naslov,
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
              onTap: () => button1Fun(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: medijakveri.size.height * 0.01,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: medijakveri.size.width * 0.2,
                  vertical: medijakveri.size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    button1Text,
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (isButton2)
              InkWell(
                onTap: () => button2Fun!(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: medijakveri.size.height * 0.01,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: medijakveri.size.width * 0.2,
                    vertical: medijakveri.size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      button2Text!,
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
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

  static String? stavke(int kolicina) {
    if (kolicina % 10 == 1 && kolicina != 11) {
      return 'stavka';
    } else if ((kolicina % 10 == 2 || kolicina % 10 == 3 || kolicina % 10 == 4) && kolicina != 12 || kolicina != 13 || kolicina != 14) {
      return 'stavke';
    }

    if (kolicina % 10 == 0 || kolicina % 10 > 4) {
      return 'stavki';
    }
    return null;
  }
}
