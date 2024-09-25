import 'package:flutter/material.dart';
import 'package:cphi/theme/strings.dart';
import 'package:cphi/view/customerWidget/boldTextView.dart';
import 'package:cphi/theme/app_colors.dart';
import 'regularTextView.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  const AlreadyHaveAnAccountCheck(
    this.login, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RegularTextView(
          text: login
              ? MyStrings.dont_have_account
              : MyStrings.already_have_account,
          color: labelColor,
          textSize: 14,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(login ? MyStrings.signup : "Login",
            style: const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                color: primaryColor)),
        //RegularTextView(text: login ? MyStrings.signup : "Login",color: primaryColor,)
      ],
    );
  }
}

class LoginLinkedin extends StatelessWidget {
  final bool login;
  const LoginLinkedin(
    this.login, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Sign in with",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                color: primaryColor)),
        const SizedBox(
          width: 6,
        ),
        Image.asset("assets/icons/linkedin.png", height: 26),
      ],
    );
  }
}

class LoginViaApple extends StatelessWidget {
  final bool login;
  const LoginViaApple(
    this.login, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Sign in with",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                color: primaryColor)),
        const SizedBox(
          width: 6,
        ),
        Image.asset("assets/icons/apple.png", height: 26),
      ],
    );
  }
}
