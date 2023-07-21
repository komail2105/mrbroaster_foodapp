import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/login/login.dart';
import 'package:mrbroaster_foodapp/views/signup/signup.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TopPart(),
            const CenterPart(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customButton(
                      width: 180,
                      onClick: () => {
                            RoutingPage.goTonextReplace(
                                context: context, navigateTo: const LoginPage())
                          },
                      title: "Login"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customButton(
                    width: 180,
                    onClick: () => {
                      RoutingPage.goTonextReplace(
                          context: context, navigateTo: const SignupPage())
                    },
                    title: "Signup",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TopPart extends StatelessWidget {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Welcome To Food Order App",
          style: TextStyle(
              fontFamily: fontProximaNova,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Login Or Signup To Continue.",
          style: TextStyle(
            fontFamily: fontProximaNova,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class CenterPart extends StatelessWidget {
  const CenterPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/applogo.png",
      fit: BoxFit.cover,
    );
  }
}
