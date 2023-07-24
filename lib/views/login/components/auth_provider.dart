import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/home/home.dart';

class AuthProviderLogin with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(AuthProviderLogin.pattern.toString());

  UserCredential? userCredential;
  bool loading = false;

  void validationLogin(
      {TextEditingController? uname,
      required TextEditingController? uemail,
      required TextEditingController? upassword,
      required BuildContext context}) async {
    if (uname!.text.trim().isEmpty || uemail!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Username Or Email")));
      return;
    } else if (upassword!.text.trim().isEmpty || upassword.text.length < 8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Enter Password")));
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: uemail.text, password: upassword.text)
            .then((value) async {
          loading = false;
          notifyListeners();
          RoutingPage.goTonextReplace(
              context: context, navigateTo: const HomePage());
          return null;
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${e.message}")));
          return;
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${e.message}")));
          return;
        }
      }
    }
  }
}
