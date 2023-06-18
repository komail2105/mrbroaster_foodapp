import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';

class SingleCartItem extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final int productQuantity;
  final String productCategory;
  final String productId;

  const SingleCartItem({
    Key? key,
    required this.productId,
    required this.productCategory,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.productName,
  }) : super(key: key);

  @override
  SingleCartItemState createState() => SingleCartItemState();
}

class SingleCartItemState extends State<SingleCartItem> {
  int quantity = 1;

  void quantityFuntion() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .update({
      "productQuantity": quantity,
    });
  }

  void deleteProductFuntion() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.productImage),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.productCategory,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Rs. ${widget.productPrice * widget.productQuantity}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            deleteProductFuntion();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: bColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 112,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 2,
                              color: bColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IncrementAndDecrement(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                    quantityFuntion();
                                  });
                                },
                              ),
                              Text(
                                widget.productQuantity.toString(),
                                style: const TextStyle(
                                    fontSize: 16, color: bColor),
                              ),
                              IncrementAndDecrement(
                                icon: Icons.remove,
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                      quantityFuntion();
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  const IncrementAndDecrement({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: bColor,
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 24,
      ),
    );
  }
}
