import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget {
  final String pageTitle;
  final IconData prvaIkonica;
  final IconData drugaIkonica;
  final Function funkcija;
  final bool isBlack;
  const CustomAppBar({required this.pageTitle, required this.prvaIkonica, required this.drugaIkonica, required this.funkcija, required this.isBlack});

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
              Icon(
                Icons.chevron_right_outlined,
                color: Colors.grey,
              ),
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
            onPressed: () {},
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
