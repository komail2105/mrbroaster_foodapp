import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/forgetpassword/forgetpassword.dart';
import 'package:mrbroaster_foodapp/views/login/components/auth_provider.dart';
import 'package:mrbroaster_foodapp/views/signup/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool showpassword = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    AuthProviderLogin authProviderLogin =
        Provider.of<AuthProviderLogin>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: fontProximaNova,
                    fontWeight: FontWeight.w700,
                    color: hColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Login to your existant account of GrocaryApp",
                  style: TextStyle(
                    fontSize: doubleSize16,
                    fontFamily: fontProximaNova,
                    fontWeight: FontWeight.w400,
                    color: dColor,
                  ),
                  textAlign: TextAlign.center,
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
                        controller: _email,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: bColor,
                            ),
                            hintText: 'Email',
                            contentPadding: edgeInsets12,
                            border: OutlineInputBorder(
                                borderRadius: borderRadiusCircular30)),
                      ),
                    ),
                    SizedBox(
                      height: 72,
                      child: TextField(
                        controller: _password,
                        obscureText: showpassword,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: bColor,
                            ),
                            suffixIcon: IconButton(
                                splashRadius: 20,
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
                            hintText: 'Password',
                            contentPadding: edgeInsets12,
                            border: OutlineInputBorder(
                                borderRadius: borderRadiusCircular30)),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                  style:
                      TextButton.styleFrom(padding: const EdgeInsets.all(2.0)),
                  onPressed: () => {
                        RoutingPage.goTonext(
                            context: context,
                            navigateTo: const ForgotPassword())
                      },
                  child: Text(
                    "Forget password?",
                    style: TextStyle(
                      color: blueColor,
                    ),
                  )),
              authProviderLogin.loading == true
                  ? const CircularProgressIndicator()
                  : customButton(
                      width: 150,
                      height: 48,
                      onClick: () => {
                        authProviderLogin.validationLogin(
                            uname: _email,
                            upassword: _password,
                            uemail: _email,
                            context: context)
                      },
                      title: "Login",
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
          "Don't have any account?",
        ),
        TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(2.0),
              alignment: Alignment.centerLeft),
          onPressed: () => {
            RoutingPage.goTonext(
                context: context, navigateTo: const SignupPage())
          },
          child: Text(
            "Signup",
            style: TextStyle(color: blueColor),
          ),
        ),
      ],
    );
  }
}
