import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/cart/cart.dart';
import 'package:mrbroaster_foodapp/views/favorite/favorite.dart';

import 'package:mrbroaster_foodapp/views/home/home.dart';
import 'package:mrbroaster_foodapp/views/profile/profile_page.dart';
import 'package:mrbroaster_foodapp/views/welcome/welcome.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: bColor),
            accountName: Text(userModel.uname),
            accountEmail: Text(userModel.uemail),
            currentAccountPicture: CircleAvatar(
              child: Image.asset("assets/images/logomrbroaster.png"),
            ),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(context: context, navigateTo: ProfilePage());
            },
            leading: const Icon(
              Icons.person,
            ),
            title: const Text("Profile"),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                  context: context, navigateTo: const CartPage());
            },
            leading: const Icon(
              Icons.shopping_cart_rounded,
            ),
            title: const Text("Cart"),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                  context: context, navigateTo: const FavoritePage());
            },
            leading: const Icon(
              Icons.favorite,
            ),
            title: const Text("Favorite"),
          ),
          const ListTile(
            leading: Icon(
              Icons.shopping_basket_sharp,
            ),
            title: Text("My Order"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    ),
                  );
            },
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text("Log out"),
          )
        ],
      ),
    );
  }
}
