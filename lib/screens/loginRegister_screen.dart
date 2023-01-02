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
          children: [
            //logo
            SizedBox(
              height: 139,
            ),
            Image.asset('assets/icons/Logo.png'),
            //text
            SizedBox(
              height: 41,
            ),
            Text(
              'Nije Bill Gates trosio ka mi!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 189,
            ),

            //login button
            Buttons(
              ButtonText: 'Log in',
              textColor: Colors.black,
            ),

            SizedBox(
              height: 20,
            ),

            //register button
            Buttons(
              ButtonText: 'Register',
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
