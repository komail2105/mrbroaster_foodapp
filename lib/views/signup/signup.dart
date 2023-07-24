import 'package:flutter/gestures.dart';
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: fontProximaNova,
                    fontWeight: FontWeight.w700,
                    color: hColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create an account to Dine Out to get access",
                  style: TextStyle(
                    fontSize: doubleSize16,
                    fontFamily: fontProximaNova,
                    fontWeight: FontWeight.w400,
                    color: dColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 72,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: _username,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: bColor,
                            ),
                            hintText: 'Enter User Name',
                            contentPadding: edgeInsets12,
                            border: OutlineInputBorder(
                                borderRadius: borderRadiusCircular30)),
                      ),
                    ),
                    SizedBox(
                      height: 72,
                      child: TextField(
                        controller: _email,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: bColor,
                            ),
                            hintText: 'Enter Email Address',
                            contentPadding: edgeInsets12,
                            border: OutlineInputBorder(
                                borderRadius: borderRadiusCircular30)),
                      ),
                    ),
                    SizedBox(
                      height: 72,
                      child: TextField(
                        controller: _phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone_android,
                              color: bColor,
                            ),
                            hintText: 'Enter Mobile Number',
                            contentPadding: edgeInsets12,
                            border: OutlineInputBorder(
                                borderRadius: borderRadiusCircular30)),
                      ),
                    ),
                    SizedBox(
                      height: 72,
                      child: TextField(
                        controller: _address,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: bColor,
                            ),
                            hintText: 'Enter Your Address',
                            contentPadding: edgeInsets12,
                            border: OutlineInputBorder(
                                borderRadius: borderRadiusCircular30)),
                      ),
                    ),
                    SizedBox(
                      height: 72,
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        controller: _password,
                        obscureText: showpassword,
                        decoration: InputDecoration(
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
                            hintText: 'Enter Password',
                            contentPadding: edgeInsets12,
                            border: OutlineInputBorder(
                                borderRadius: borderRadiusCircular30)),
                      ),
                    ),
                  ],
                ),
              ),
              authProviderSignup.loading == false
                  ? customButton(
                      width: 150,
                      height: 48,
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
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(2.0),
              alignment: Alignment.centerLeft),
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
