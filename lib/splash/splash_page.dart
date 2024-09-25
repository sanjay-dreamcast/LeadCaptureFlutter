import 'package:cphi/splash/splash_controller.dart';
import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:cphi/view/customerWidget/loading.dart';
import 'package:cphi/view/customerWidget/regularTextView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';

class SplashScreen extends GetView<SplashController> {
  SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/";
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: context.width,
              height: context.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset(
                        'assets/images/splash.png',
                        height: context.height,
                        width: context.width,
                        fit: BoxFit.cover,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            child: Image.asset(
                          "assets/images/logo.png",
                          height: 60,
                          width: 200,
                        )),
                      ),
                      const Text(
                        "Lead Capture",
                        style: TextStyle(
                            fontFamily: "Figtree",
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
