import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/provider/favorite_provider.dart';
import 'package:mrbroaster_foodapp/views/home/home.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatefulWidget {
  final String productId;
  final String productCategory;
  final int productRate;
  final int productPrice;
  final String productImage;
  final String productName;
  final String productDescription;
  final Function()? onTap;
  const SingleProduct({
    Key? key,
    required this.onTap,
    required this.productId,
    required this.productCategory,
    required this.productRate,
    required this.productPrice,
    required this.productImage,
    required this.productName,
    required this.productDescription,
  }) : super(key: key);

  @override
  SingleProductState createState() => SingleProductState();
}

class SingleProductState extends State<SingleProduct> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      isFavorite = value.get("productFavorite");
                    }),
                  }
              }
          },
        );

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.topRight,
            height: size!.height * 0.2,
            width: size!.width / 2 - 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.productImage),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                setState(
                  () {
                    isFavorite = !isFavorite;

                    if (isFavorite == true) {
                      favoriteProvider.favorite(
                        productId: widget.productId,
                        productCategory: widget.productCategory,
                        productRate: widget.productRate,
                        productPrice: widget.productPrice,
                        productImage: widget.productImage,
                        productName: widget.productName,
                        productDescription: widget.productDescription,
                        productFavorite: true,
                      );
                    } else if (isFavorite == false) {
                      favoriteProvider.deleteFavorite(
                          productId: widget.productId);
                    }
                  },
                );
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: bColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Rs. ${widget.productPrice}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
