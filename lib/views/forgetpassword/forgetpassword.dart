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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Enter Your Existing Email Below To Reset Your Password.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 72,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value.trim();
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusedBorder: outlineInputBorder,
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
            customButton(
                height: 44,
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
                width: 140)
          ],
        ),
      ),
    );
  }
}
