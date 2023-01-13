import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String ButtonText;
  final color;
  final textColor;

  const Button({super.key, required this.ButtonText, this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Color.fromRGBO(85, 74, 240, 1),
          ),
          borderRadius: BorderRadius.circular(27)),
      child: Center(
        child: Text(
          ButtonText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}
