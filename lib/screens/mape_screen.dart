import 'package:flutter/material.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/components/search_bar.dart';

class MapeScreen extends StatelessWidget {
  const MapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: CustomAppBar(pageTitle: 'Mape'),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: SearchBar(hintText: 'Pretražite grad...'),
        ),
      ],
    );
  }
}
