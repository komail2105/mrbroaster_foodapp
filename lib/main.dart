import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/provider/cart_provider.dart';
import 'package:mrbroaster_foodapp/provider/favorite_provider.dart';
import 'package:mrbroaster_foodapp/views/home/home.dart';
import 'package:mrbroaster_foodapp/views/login/components/auth_provider.dart';
import 'package:mrbroaster_foodapp/views/signup/components/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mrbroaster_foodapp/views/welcome/welcome.dart';
import 'package:provider/provider.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.enableNetwork();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: bColor),
  );

  runApp(InternetWidget(
    loadingWidget: const CircularProgressIndicator(
      color: bColor,
    ),
    online: const MyApp(),
    offline:
        const Center(child: Text("No Internet. Turn On Wifi Or Mobile Data")),
    //   whenOnline: () => navigatorKey.currentContext,
    whenOffline: () => const CircularProgressIndicator(
      color: bColor,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    outlineInputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: color ?? Colors.black54,
          width: 1.50,
        ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProviderSignup(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProviderLogin(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
        // navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: outlineInputBorder(),
            enabledBorder:
                outlineInputBorder(color: Colors.black.withOpacity(0.75)),
            floatingLabelStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (userSnapshot.connectionState == ConnectionState.active ||
                userSnapshot.connectionState == ConnectionState.done) {
              if (userSnapshot.hasError) {
                return const Text('Error');
              } else if (userSnapshot.hasData) {
                return const HomePage();
              } else {
                return const WelcomePage();
              }
            }
            return const WelcomePage();
          },
        ),
      ),
    );
  }
}
