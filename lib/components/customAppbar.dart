import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget {
  final String pageTitle;
  final IconData prvaIkonica;
  final double? prvaIkonicaSize;
  final Function funkcija;
  final IconData? drugaIkonica;

  final Function? funkcija2;
  final bool isBlack;
  final bool isChevron;
  final bool isCenter;

  const CustomAppBar({
    required this.pageTitle,
    required this.prvaIkonica,
    this.prvaIkonicaSize,
    required this.funkcija,
    this.drugaIkonica,
    this.funkcija2,
    required this.isBlack,
    required this.isChevron,
    required this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    return isCenter
        ? SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: (medijakveri.size.height - medijakveri.padding.top) * 0.04),
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
              height: (medijakveri.size.height - medijakveri.padding.top) * 0.04 + 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => funkcija(),
                        icon: Icon(
                          prvaIkonica,
                          size: prvaIkonicaSize,
                        ),
                      ),
                      if (isChevron)
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.grey,
                        ),
                      if (!isChevron) SizedBox(width: 5),
                    ],
                  ),
                  Text(
                    pageTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: (isBlack) ? Colors.black : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () => funkcija2!(),
                    icon: Icon(
                      drugaIkonica,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: (medijakveri.size.height - medijakveri.padding.top) * 0.04),
              margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.07),
              height: (medijakveri.size.height - medijakveri.padding.top) * 0.04 + 50,
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
                          icon: Icon(
                            prvaIkonica,
                            size: prvaIkonicaSize,
                          ),
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
                    onPressed: () => funkcija2!(),
                    icon: Icon(
                      drugaIkonica,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
