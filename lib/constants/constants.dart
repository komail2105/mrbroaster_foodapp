import 'package:flutter/material.dart';

var buttonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  minimumSize: MaterialStateProperty.resolveWith(
    (states) => const Size(132, 48),
  ),
  backgroundColor: MaterialStateProperty.resolveWith(
    (states) => bColor,
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: borderRadiusCircular30,
    ),
  ),
);

const edgeInsets12 = EdgeInsets.all(12);

const fontProximaNova = "Proxima Nova";

const bColor = Color(0xFFCDE252);

const wColor = Colors.white;

const hColor = Color.fromARGB(255, 64, 64, 64);

const dColor = Color.fromARGB(255, 110, 110, 110);

final blueColor = Colors.blue.shade700;

final borderRadiusCircular30 = BorderRadius.circular(30);

double mediaQuery(BuildContext context) => MediaQuery.of(context).size.width;
double mediaQueryheight(BuildContext context) =>
    MediaQuery.of(context).size.height;

var doubleSize16 = 16.0;
var doubleSize30 = 30.0;

Widget customButton(
    {required VoidCallback onClick,
    required String title,
    double? height = 50,
    double? width = 120,
    double? fontSize = 16}) {
  return Container(
      padding: edgeInsets12,
      decoration:
          BoxDecoration(color: bColor, borderRadius: borderRadiusCircular30),
      height: height,
      width: width,
      child: InkWell(
        onTap: onClick,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(color: wColor, fontSize: fontSize),
              ),
            ),
          ],
        ),
      ));
}
