import 'package:cphi/theme/app_colors.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';
import 'package:cphi/view/customerWidget/semiBoldTextView.dart';
import 'package:flutter/material.dart';
class MyFlowWidget extends StatelessWidget {
  final String text;
  bool isBgColor=false;

  MyFlowWidget(this.text,{super.key,required this.isBgColor});

  @override
  Widget build(BuildContext context) {
    return text.isNotEmpty?Container(
      margin: const EdgeInsets.only(right: 6,bottom: 6,top: 6),
      padding: EdgeInsets.all(isBgColor?6:0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: isBgColor?homeColor:Colors.transparent,
          border: Border.all(color: isBgColor?homeColor:Colors.transparent)),
      child: RegularTextView(text:
        text,color: Colors.black,textAlign: TextAlign.start,textSize: 14,
      ),
    ):const SizedBox();
  }

}