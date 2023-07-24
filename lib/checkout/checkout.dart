import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/checkout/payment.dart';
import 'package:mrbroaster_foodapp/provider/cart_provider.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/widgets/singlecartitem.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  CheckOutPageState createState() => CheckOutPageState();
}

class CheckOutPageState extends State<CheckOutPage> {
  late double totalPrice;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    double subTotal = cartProvider.subTotal();

    double discount = 5;
    int shipping = 10;

    double discountValue = (subTotal * discount) / 100;

    double value = subTotal - discountValue;

    totalPrice = value += shipping;

    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalPrice = 0.0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Check out",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.getCartList.isEmpty
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
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: const Text("Sub Total"),
                  trailing: Text("Rs.$subTotal"),
                ),
                const ListTile(
                  leading: Text("Discount"),
                  trailing: Text("%5"),
                ),
                const ListTile(
                  leading: Text("Shiping"),
                  trailing: Text("Rs.10"),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: const Text("Total"),
                  trailing: Text("Rs.$totalPrice"),
                ),
                cartProvider.getCartList.isEmpty
                    ? const Text("")
                    : TextButton(
                        onPressed: () => RoutingPage.goTonextReplace(
                            context: context, navigateTo: const PaymentPage()),
                        child: const Text("Buy"),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
