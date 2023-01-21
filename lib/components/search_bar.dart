import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  const SearchBar(this.hintText);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 60,
        child: TextField(
          textInputAction: TextInputAction.newline,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.indigo,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: widget.hintText,
            contentPadding: EdgeInsets.only(left: 20, top: 30),
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            suffixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Iconsax.search_normal,
                size: 34,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
