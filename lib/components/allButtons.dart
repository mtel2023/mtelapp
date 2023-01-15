import 'package:flutter/material.dart';

class allButtons extends StatelessWidget {
  final String ButtonText;
  final backgoundColor;
  final textColor;
  final double textSize;
  final FontWeight;

  const allButtons({
    required this.ButtonText,
    this.backgoundColor,
    this.textColor,
    required this.textSize,
    this.FontWeight,
  });
  //const allButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.021),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07),
      decoration: BoxDecoration(
        color: backgoundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          ButtonText,
          style: TextStyle(
            fontWeight: FontWeight,
            fontSize: textSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
