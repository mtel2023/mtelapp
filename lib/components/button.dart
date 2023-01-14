import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color? color;
  final Color textColor;
  final bool isBorder;
  final double visina;
  final double borderRadius;

  const Button({required this.borderRadius, required this.visina, required this.buttonText, this.color, required this.textColor, required this.isBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: visina),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: isBorder ? Theme.of(context).primaryColor : Colors.white,
          ),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}
