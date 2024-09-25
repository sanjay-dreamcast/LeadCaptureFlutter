
import 'package:flutter/material.dart';
import 'package:cphi/theme/app_colors.dart';

import 'toolbarTitle.dart';

class CustomToolbar extends StatelessWidget {
  final String title;

  const CustomToolbar(
    this.title, {
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
      ]),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                elevation: 20,
                color: Colors.transparent,
                child: InkWell(
                highlightColor: Colors.red,
                child: Icon(
                  Icons.navigate_before,
                  size: 40,
                  color: Colors.white,
                ),
              ),),
              Align(
                child: ToolbarTitle(title: title, color: Colors.red,),
                alignment: Alignment.center,
              ),
              Icon(
                Icons.navigate_before,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
