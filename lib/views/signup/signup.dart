import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/login/login.dart';
import 'package:mrbroaster_foodapp/views/signup/components/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool showpassword = true;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProviderSignup authProviderSignup =
        Provider.of<AuthProviderSignup>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 36,
                fontFamily: fontProximaNova,
                fontWeight: FontWeight.w700,
                color: hColor,
              ),
            ),
            Text(
              "Create an account to Dine Out to get access",
              style: TextStyle(
                fontSize: doubleSize16,
                fontFamily: fontProximaNova,
                fontWeight: FontWeight.w400,
                color: dColor,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: mediaQuery(context) - 72,
                  height: 72,
                  child: TextField(
                    controller: _username,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: bColor,
                        ),
                        hintText: 'example@gmail.com',
                        contentPadding: edgeInsets15,
                        border: OutlineInputBorder(
                            borderRadius: borderRadiusCircular30)),
                  ),
                ),
                SizedBox(
                  width: mediaQuery(context) - 72,
                  height: 72,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: bColor,
                        ),
                        hintText: 'example@gmail.com',
                        contentPadding: edgeInsets15,
                        border: OutlineInputBorder(
                            borderRadius: borderRadiusCircular30)),
                  ),
                ),
                SizedBox(
                  width: mediaQuery(context) - 72,
                  height: 72,
                  child: TextField(
                    controller: _phone,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        prefixIcon: const Icon(
                          Icons.phone_android,
                          color: bColor,
                        ),
                        hintText: 'example@gmail.com',
                        contentPadding: edgeInsets15,
                        border: OutlineInputBorder(
                            borderRadius: borderRadiusCircular30)),
                  ),
                ),
                SizedBox(
                  width: mediaQuery(context) - 72,
                  height: 72,
                  child: TextField(
                    controller: _address,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        prefixIcon: const Icon(
                          Icons.location_city,
                          color: bColor,
                        ),
                        hintText: 'street 1, house 10',
                        contentPadding: edgeInsets15,
                        border: OutlineInputBorder(
                            borderRadius: borderRadiusCircular30)),
                  ),
                ),
                SizedBox(
                  width: mediaQuery(context) - 72,
                  height: 72,
                  child: TextField(
                    controller: _password,
                    obscureText: showpassword,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: bColor,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () => {
                                  setState(() {
                                    showpassword = !showpassword;
                                  })
                                },
                            icon: showpassword
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: bColor,
                                    size: 24,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: bColor,
                                    size: 24,
                                  )),
                        hintText: '12345678',
                        contentPadding: edgeInsets15,
                        border: OutlineInputBorder(
                            borderRadius: borderRadiusCircular30)),
                  ),
                ),
              ],
            ),
            authProviderSignup.loading == false
                ? customButton(
                    width: 150,
                    onClick: () => {
                      authProviderSignup.validationSignup(
                          uname: _username,
                          upassword: _password,
                          uemail: _email,
                          uphone: _phone,
                          uaddress: _address,
                          context: context)
                    },
                    title: "Sign Up",
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: bColor,
                    ),
                  ),
            const BottomPart(),
          ],
        ),
      ),
    );
  }
}

class BottomPart extends StatelessWidget {
  const BottomPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
        ),
        TextButton(
          onPressed: () => {
            RoutingPage.goTonext(
                context: context, navigateTo: const LoginPage())
          },
          child: Text(
            "Login",
            style: TextStyle(color: blueColor),
          ),
        ),
      ],
    );
  }
}
