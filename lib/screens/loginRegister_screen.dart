import 'package:flutter/material.dart';
import 'package:mtelapp/components/button.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('assets/icons/Logo.png'),
                SizedBox(
                  height: 41,
                ),
                Text(
                  'Nije Bill Gates trošio ka mi!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Buttons(
                  ButtonText: 'Log in',
                  textColor: Colors.black,
                ),
                SizedBox(height: 20),
                Buttons(
                  ButtonText: 'Register',
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
