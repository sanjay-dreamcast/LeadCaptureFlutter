import 'package:flutter/material.dart';
import 'package:cphi/theme/app_colors.dart';

class RoundedPasswordInputField extends StatefulWidget {
  final FormFieldValidator<String> validator;
  final FormFieldValidator<String> onChanged;

  final TextInputAction inputAction;
  final String hintText;
  final TextEditingController controller;

  const RoundedPasswordInputField({
    Key? key,
    required this.inputAction,
    required this.validator,
    required this.onChanged,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _RoundedPasswordInputFieldState createState() =>
      _RoundedPasswordInputFieldState();
}

class _RoundedPasswordInputFieldState extends State<RoundedPasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.inputAction,
      obscureText: _obscureText,
      cursorColor: primaryColor,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: inputDecoration(widget.hintText, Icons.person),
      //maxLength: 20,
    /*  decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: grayColorLight)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greyColor, width: 1),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10.0)),
          filled: true,
          hintStyle: TextStyle(color: grayColorLight),
          hintText: widget.hintText,
          fillColor: Colors.white70),*/
    );
  }

  InputDecoration inputDecoration(String labelText, IconData iconData,
      {String? prefix, String? helperText}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      helperText: helperText,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey),
      fillColor: Colors.transparent,
      filled: true,
      prefixText: prefix,
      /*prefixIcon: Icon(
        iconData,
        size: 20,
      ),*/
      suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: grayColorLight)),
      prefixIconConstraints: BoxConstraints(minWidth: 60),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.amberAccent)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.red)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.black)),
    );
  }
}

