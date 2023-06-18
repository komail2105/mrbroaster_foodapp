import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/home/home.dart';

class AuthProviderSignup with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(AuthProviderSignup.pattern.toString());

  UserCredential? userCredential;

  bool loading = false;

  void validationSignup(
      {required TextEditingController? uname,
      required TextEditingController? uemail,
      required TextEditingController? uphone,
      required TextEditingController? upassword,
      TextEditingController? uaddress,
      required BuildContext context}) async {
    if (uname!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter User Name")));
      return;
    } else if (uemail!.text.trim().isEmpty ||
        !regExp.hasMatch(uemail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter A Valid Email Address")));
      return;
    } else if (uphone!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Phone Number")));
      return;
    } else if (upassword!.text.trim().isEmpty || upassword.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter A Valid Password")));
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: uemail.text, password: upassword.text);
        loading = true;
        notifyListeners();
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.user!.uid)
            .set({
          "uname": uname.text,
          "uemail": uemail.text,
          "upassword": upassword.text,
          "uphone": uphone.text,
          "uaddress": uaddress!.text,
          "userUid": userCredential!.user!.uid,
        }).then((value) {
          loading = false;
          notifyListeners();
          RoutingPage.goTonextReplace(
              context: context, navigateTo: const HomePage());
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Weak Password.")));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email Already In Use.")));
        }
      }
    }
  }
}
