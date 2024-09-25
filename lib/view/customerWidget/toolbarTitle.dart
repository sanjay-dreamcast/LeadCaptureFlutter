import 'package:cphi/theme/app_colors.dart';
import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:flutter/material.dart';

class ToolbarTitle1 extends StatelessWidget {
  final String title;
  final Color color;
  final String subTitle;
  final Function press;
  const ToolbarTitle1({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.press,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: primaryColor, fontSize: 18, fontWeight: FontWeight.normal),
        ),
        GestureDetector(
          onTap: () {
            Future.delayed(Duration.zero, () async {
              press();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              subTitle,
              style: TextStyle(
                color: black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ToolbarTitle extends StatelessWidget {
  final String title;
  final Color color;
  const ToolbarTitle({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoldTextView(
      text: title,
      textSize: 24,
      color: color,
    );
  }
}
