import 'package:flutter/material.dart';
import 'package:cphi/theme/strings.dart';
import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RegularTextView(text: "OR",textSize: 14,textAlign: TextAlign.center,color: Colors.black,),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}
