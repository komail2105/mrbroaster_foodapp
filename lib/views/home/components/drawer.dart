import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/cart/cart.dart';
import 'package:mrbroaster_foodapp/views/favorite/favorite.dart';

import 'package:mrbroaster_foodapp/views/home/home.dart';
import 'package:mrbroaster_foodapp/views/profile/profile_page.dart';
import 'package:mrbroaster_foodapp/views/welcome/welcome.dart';

import '../../products/products.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    getProfileImage() {
      if (firebaseAuth.currentUser!.photoURL != null) {
        return Image.asset(
          firebaseAuth.currentUser!.photoURL.toString(),
          height: 72,
          width: 72,
        );
      } else {
        return const Icon(
          Icons.account_circle,
          size: 72,
        );
      }
    }

    return Drawer(
      elevation: 0,
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(color: bColor),
            accountName: Text(userModel.uname),
            accountEmail: Text(userModel.uemail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: getProfileImage(),
            ),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(context: context, navigateTo: ProfilePage());
            },
            leading: const Icon(
              Icons.person,
            ),
            minLeadingWidth: 32,
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
            minLeadingWidth: 32,
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
            minLeadingWidth: 32,
            title: const Text("Favorite"),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                  context: context, navigateTo: const ProductsPage());
            },
            leading: const Icon(
              Icons.square_rounded,
            ),
            minLeadingWidth: 32,
            title: const Text("Products"),
          ),
          const ListTile(
            leading: Icon(
              Icons.receipt_rounded,
            ),
            minLeadingWidth: 32,
            title: Text("Bills"),
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
            minLeadingWidth: 32,
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text("Log out"),
          ),
        ],
      ),
    );
  }
}
