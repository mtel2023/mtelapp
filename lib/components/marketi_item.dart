import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class MarketiItem extends StatelessWidget {
  final MediaQueryData medijakveri;
  final String title;
  final String logo;
  const MarketiItem({required this.medijakveri, required this.title, required this.logo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/'),
      child: Container(
        margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 80,
                        width: 110,
                        child: Image.network(
                          logo,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(.0),
                            Colors.white.withOpacity(.8),
                          ],
                          stops: [0.2, 0.8],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: medijakveri.size.width * 0.08),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
