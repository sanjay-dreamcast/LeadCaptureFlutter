import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cphi/theme/app_colors.dart';

import '../../routes/my_constant.dart';

class customTextView extends StatelessWidget {
  final String text;
  final Color color;
  final double textSize;
  final bool underline;
  final bool centerUnderline;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final FontWeight weight;
  final int maxLines;

  const customTextView(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.textSize = 14,
      this.underline = false,
      this.centerUnderline = false,
      this.fontStyle = FontStyle.normal,
      this.textAlign = TextAlign.center,
      this.weight = FontWeight.w400,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,softWrap: true,
        style: TextStyle(
            color: color,
            fontStyle: fontStyle,
            fontFamily: MyConstant.currentFont,
            fontWeight: FontWeight.w400,
            fontSize: textSize,
            decoration: underline
                ? TextDecoration.underline
                : centerUnderline
                ? TextDecoration.overline
                : TextDecoration.none));
  }
}
