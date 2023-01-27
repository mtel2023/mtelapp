import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Trebovanje/providers/market_provider.dart';
import 'package:Trebovanje/providers/proizvod_provider.dart';
import 'package:Trebovanje/screens/search_screen.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final String pretraga;
  const SearchBar({required this.hintText, required this.pretraga});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextField(
        controller: searchcontroller,
        onSubmitted: (value) {
          if (searchcontroller.text == '') {
            return;
          }
          if (widget.pretraga == 'proizvod') {
            print('PROIZVOD');
            Provider.of<Proizvodi>(context, listen: false).searchProizvod(searchcontroller.text);
          } else if (widget.pretraga == 'market') {
            print('MARKET');

            Provider.of<Marketi>(context, listen: false).searchMarket(searchcontroller.text);
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => SearchScreen(
                searchText: searchcontroller.text,
                pretraga: widget.pretraga,
              ),
            ),
          );
        },
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
            fontSize: 16,
            color: Colors.grey,
            decoration: TextDecoration.none,
          ),
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () async {
                if (searchcontroller.text == '') {
                  return;
                }

                if (widget.pretraga == 'proizvod') {
                  print('PROIZVOD');
                  Provider.of<Proizvodi>(context, listen: false).searchProizvod(searchcontroller.text);
                } else if (widget.pretraga == 'market') {
                  print('MARKET');

                  Provider.of<Marketi>(context, listen: false).searchMarket(searchcontroller.text);
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => SearchScreen(
                          searchText: searchcontroller.text,
                          pretraga: widget.pretraga,
                        )));
              },
              child: Icon(
                Iconsax.search_normal,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
