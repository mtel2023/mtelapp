import 'package:flutter/material.dart';

class inputField extends StatelessWidget {
  final MediaQueryData medijakveri;
  final String label;
  final String? hintText;
  final String? initalValue;
  final TextInputAction doneAction;
  final TextInputType keyboardTip;
  final bool obscureText;
  final String? Function(String? p1)? validator;
  final Function(String? p1)? onSaved;
  final Function(String? p1)? onChanged;
  final Function(String? p1)? onFieldSubmitted;
  final FocusNode? focusNode;
  const inputField({
    Key? key,
    required this.medijakveri,
    required this.label,
    this.hintText,
    this.initalValue,
    this.focusNode,
    required this.doneAction,
    required this.keyboardTip,
    required this.obscureText,
    required this.validator,
    required this.onSaved,
    this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: (medijakveri.size.height - medijakveri.padding.top) * 0.005,
              left: medijakveri.size.width * 0.02,
            ),
            child: Text(label),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TextFormField(
              keyboardType: keyboardTip,
              textInputAction: doneAction,
              obscureText: obscureText,
              focusNode: focusNode,
              onChanged: onChanged,
              validator: validator,
              onSaved: onSaved,
              onFieldSubmitted: onFieldSubmitted,
              initialValue: initalValue,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
