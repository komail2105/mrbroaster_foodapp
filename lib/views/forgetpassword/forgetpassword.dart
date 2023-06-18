import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Enter Your Existing Email Below To Reset Your Password.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  focusedBorder: outlineInputBorder,
                  hintText: "Email",
                  border:
                      OutlineInputBorder(borderRadius: borderRadiusCircular30)),
              onChanged: (value) {
                setState(() {
                  email = value.trim();
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            customButton(
                onClick: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email!)
                      .whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "An email has been send $email to please verify",
                            ),
                          ),
                        ),
                      );
                },
                title: "Send Request",
                width: 150)
          ],
        ),
      ),
    );
  }
}
