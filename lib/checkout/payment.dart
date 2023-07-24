import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/provider/cart_provider.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/home/home.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var value = 0;
  final paymentLabels = [
    'Cash On Dilvery',
    'Credit Card / Debit Card',
  ];
  final paymentIcons = [
    Icons.money_off,
    Icons.credit_card,
  ];

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
        backgroundColor: wColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(
                20,
              ),
              child: Text(
                "Choose Your Payment Method",
                style: TextStyle(fontSize: 28),
              )),
          Expanded(
            child: ListView.separated(
              itemCount: paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: bColor,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = index),
                  ),
                  title: Text(
                    paymentLabels[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(paymentIcons[index]),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: customButton(
                onClick: () => {
                      RoutingPage.goTonextReplace(
                          context: context, navigateTo: const Success()),
                      cartProvider.cartList.clear(),
                    },
                title: "Pay"),
          )
        ],
      ),
    );
  }
}

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Payment Was Done Successfully",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/image_success.gif",
                  height: 250,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Text(
                    "Success",
                    style: TextStyle(fontSize: 20, color: bColor),
                  ),
                )
              ],
            ),
            customButton(
                onClick: () => {
                      setState(() {}),
                      RoutingPage.goTonextReplace(
                          context: context, navigateTo: const HomePage())
                    },
                title: 'Done'),
          ],
        ),
      ),
    );
  }
}
