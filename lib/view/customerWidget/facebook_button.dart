
import 'package:flutter/material.dart';
import 'package:cphi/theme/app_colors.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';

class FacebookButton extends StatelessWidget {
  final String? text;
  final String? path;
  final Function press;
  final Color? color, textColor;

  const FacebookButton({
    Key? key,
    this.path,
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      width: size.width * 0.8,
      height: 45,
      child: OutlinedButton(
          child: Row(
            children: [
              Image.asset(
                path.toString(),
                width: 25,
                height: 25,
              ),
              SizedBox(
                width: 6,
              ),
              RegularTextView(
                text: text.toString(),
                textSize: 17,
                color: textColor!,
              )
            ],
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: color,
            side: BorderSide(color: greyColor, width: 1),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.5))),
          ),
          onPressed: () {
            Future.delayed(Duration.zero, () async {
              press();
            });
          }),
    );
  }
}
