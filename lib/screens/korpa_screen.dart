import 'package:flutter/material.dart';

class KorpaScreen extends StatelessWidget {
  static const routeName = '/korpa';
  const KorpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Korpa')),
    );
  }
}
