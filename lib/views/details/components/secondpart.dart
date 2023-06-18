import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/cart/cart.dart';

class SecondPart extends StatelessWidget {
  final String productName;
  final int productPrice;

  final int productRate;
  final String productDescription;
  final String productId;
  final String productImage;
  final String productCategory;
  const SecondPart({
    Key? key,
    required this.productCategory,
    required this.productImage,
    required this.productId,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    required this.productRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                "Rs.$productPrice",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Column(
            children: [
              const Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "50 Reviews",
                    style: TextStyle(
                      color: bColor,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: bColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        productRate.toString(),
                        style: const TextStyle(
                          color: wColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
          const Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            productDescription,
            style: const TextStyle(color: Colors.black38),
          ),
          Align(
              alignment: Alignment.center,
              child: customButton(
                onClick: () {
                  FirebaseFirestore.instance
                      .collection("cart")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("userCart")
                      .doc(productId)
                      .set(
                    {
                      "productId": productId,
                      "productImage": productImage,
                      "productName": productName,
                      "productPrice": productPrice,
                      "productOldPrice": productPrice,
                      "productRate": productRate,
                      "productDescription": productDescription,
                      "productQuantity": 1,
                      "productCategory": productCategory,
                    },
                  );
                  RoutingPage.goTonext(
                    context: context,
                    navigateTo: const CartPage(),
                  );
                },
                width: 160,
                title: "Add to Cart",
              )),
        ],
      ),
    );
  }
}
