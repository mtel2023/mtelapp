import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget {
  final String pageTitle;
  final IconData prvaIkonica;
  final IconData drugaIkonica;
  final Function funkcija;
  final Function funkcija2;

  final bool isBlack;
  final bool isChevron;
  const CustomAppBar({
    required this.pageTitle,
    required this.prvaIkonica,
    required this.drugaIkonica,
    required this.funkcija,
    required this.funkcija2,
    required this.isBlack,
    required this.isChevron,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 25,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => funkcija(),
                  icon: Icon(prvaIkonica),
                ),
              ),
              if (isChevron)
                Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.grey,
                ),
              if (!isChevron) SizedBox(width: 5),
              Text(
                pageTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: (isBlack) ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => funkcija2(),
            icon: Icon(
              drugaIkonica,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
