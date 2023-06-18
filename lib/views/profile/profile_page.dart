import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/home/home.dart';

class ProfilePage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final RegExp regExp = RegExp(ProfilePage.pattern.toString());

  ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool isEdit = false;

  TextEditingController uname = TextEditingController(text: userModel.uname);
  TextEditingController uemail = TextEditingController(text: userModel.uemail);
  TextEditingController uphone = TextEditingController(text: userModel.uphone);

  TextEditingController uaddress =
      TextEditingController(text: userModel.uaddress);

  Widget textFromField({required String hintText}) {
    return Container(
      height: 50,
      width: mediaQuery(context) - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: ListTile(
        leading: Text(hintText),
      ),
    );
  }

  void profileVaidation(
      {required TextEditingController? uemail,
      required TextEditingController? uname,
      required TextEditingController? uphone,
      TextEditingController? uaddress,
      required BuildContext context}) async {
    if (uname!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Name is Empty."),
        ),
      );
      return;
    } else if (uemail!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Address Is Empty."),
        ),
      );
      return;
    } else if (uphone!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Your Number"),
        ),
      );
      return;
    } else if (!widget.regExp.hasMatch(uemail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email address"),
        ),
      );
      return;
    } else {
      buildUpdateProfile();
    }
  }

  Widget nonEditTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundImage:
                  AssetImage("assets/images/default_profile_pic.png"),
              radius: 50,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.uname),
        const SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.uemail),
        const SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.uphone),
        const SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.uaddress),
      ],
    );
  }

  Widget editTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundImage:
                  AssetImage("assets/images/default_profile_pic.png"),
              radius: 50,
            ),
          ],
        ),
        TextFormField(
          controller: uname,
          decoration: const InputDecoration(hintText: "uname"),
        ),
        TextFormField(
          controller: uemail,
          decoration: const InputDecoration(
            hintText: "emailAddress",
          ),
        ),
        TextFormField(
          controller: uaddress,
          decoration: const InputDecoration(
            hintText: "Address",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            profileVaidation(
              context: context,
              uemail: uemail,
              uname: uname,
              uphone: uphone,
              uaddress: uaddress,
            );
          },
          child: const Text("Update"),
        )
      ],
    );
  }

  Future buildUpdateProfile() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        "uname": uname.text,
        "uemail": uemail.text,
        "uphone": uphone.text,
        "uaddress": uaddress.text,
      },
    ).then(
      (value) => RoutingPage.goTonext(
        context: context,
        navigateTo: const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: isEdit
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: const Icon(Icons.close),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEdit = true;
              });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: isEdit ? editTextField() : nonEditTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
