import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/checkout/checkout.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/provider/cart_prodiver.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/widgets/singlecartitem.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    return Scaffold(
      bottomNavigationBar: cartProvider.getCartList.isEmpty
          ? const Text("")
          : TextButton(
              child: const Text("Check Out"),
              onPressed: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: const CheckOutPage(),
                );
              },
            ),
      appBar: AppBar(
        backgroundColor: bColor,
        elevation: 0,
      ),
      body: cartProvider.getCartList.isEmpty
          ? const Center(
              child: Text("No Product"),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cartProvider.getCartList.length,
              itemBuilder: (ctx, index) {
                var data = cartProvider.cartList[index];
                return SingleCartItem(
                  productId: data.productId,
                  productCategory: data.productCategory,
                  productImage: data.productImage,
                  productPrice: data.productPrice,
                  productQuantity: data.productQuantity,
                  productName: data.productName,
                );
              },
            ),
    );
  }
}
