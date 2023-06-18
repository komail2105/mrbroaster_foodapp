import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/views/details/components/secondpart.dart';
import 'package:mrbroaster_foodapp/views/details/components/toppart.dart';

class DetailsPage extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productCategory;
  final int productPrice;
  final String productId;
  final int productRate;
  final String productDescription;

  const DetailsPage({
    Key? key,
    required this.productCategory,
    required this.productId,
    required this.productDescription,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productRate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            TopPart(
              productImage: productImage,
            ),
            SecondPart(
              productCategory: productCategory,
              productImage: productImage,
              productId: productId,
              productDescription: productDescription,
              productName: productName,
              productPrice: productPrice,
              productRate: productRate,
            ),
          ],
        ),
      ),
    );
  }
}
