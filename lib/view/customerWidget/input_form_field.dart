import 'package:cphi/routes/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cphi/theme/app_colors.dart';

class InputFormField extends StatelessWidget {
  final String hintText;
  final bool isMobile;
  final int maxLength;
  final IconData icon;
  final String inputExperssion;
  final TextInputType inputType;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;

  const InputFormField({
    Key? key,
    this.inputExperssion = "",
    this.isMobile = false,
    required this.controller,
    required this.inputAction,
    required this.inputType,
    required this.hintText,
    this.maxLength = 50,
    this.icon = Icons.person,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      autofocus: false,
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      validator: validator,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: isMobile ? 22 : 22, fontFamily: MyConstant.currentFont),
      cursorColor: primaryColor,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(isMobile ? 0 : 0, 15, 0, 15),
          filled: true,
          hintStyle: const TextStyle(
              color: mobileColor,
              fontFamily: MyConstant.currentFont,
              fontWeight: FontWeight.bold,
              fontSize: 22),
          hintText: hintText,
          fillColor: Colors.white70),
    );
  }
}

class InputFormFieldMobile extends StatelessWidget {
  final String hintText;
  final bool isMobile;
  final int maxLength;
  final IconData icon;
  final String inputExperssion;
  final TextInputType inputType;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;

  const InputFormFieldMobile({
    Key? key,
    this.inputExperssion = "",
    this.isMobile = false,
    required this.controller,
    required this.inputAction,
    required this.inputType,
    required this.hintText,
    this.maxLength = 50,
    this.icon = Icons.person,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false, autocorrect: false, autofocus: false,
      controller: controller,
      textInputAction: inputAction,
      //keyboardType: inputType,
      maxLength: maxLength,
      validator: validator, textAlign: TextAlign.start,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      //maxLength: 10,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(
          fontSize: 30,
          fontFamily: MyConstant.currentFont,
          fontWeight: FontWeight.bold),
      cursorColor: primaryColor,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(isMobile ? 15 : 15, 15, 15, 15),
          filled: true,
          hintStyle: const TextStyle(
              color: mobileColor, fontFamily: MyConstant.currentFont),
          hintText: hintText,
          fillColor: Colors.white70),
    );
  }
}
