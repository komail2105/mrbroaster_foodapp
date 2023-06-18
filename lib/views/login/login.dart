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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 36,
                fontFamily: fontProximaNova,
                fontWeight: FontWeight.w700,
                color: hColor,
              ),
            ),
            Text(
              "Login to your existant account of Dine Out",
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
                    controller: _email,
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
            TextButton(
                onPressed: () => {
                      RoutingPage.goTonext(
                          context: context, navigateTo: const ForgotPassword())
                    },
                child: Text(
                  "Forget password?",
                  style: TextStyle(
                    color: blueColor,
                  ),
                )),
            authProviderLogin.loading == true
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      minimumSize: MaterialStateProperty.resolveWith(
                        (states) => const Size(172, 48),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => bColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(doubleSize30),
                        ),
                      ),
                    ),
                    onPressed: () => {
                          authProviderLogin.validationLogin(
                              uname: _email,
                              uemail: _email,
                              upassword: _password,
                              context: context)
                        },
                    child: const Text(
                      "Login",
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have any account?",
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()))
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
