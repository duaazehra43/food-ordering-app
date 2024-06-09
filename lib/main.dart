import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/models/CartModel.dart';
import 'package:food_order_app/models/favModel.dart';
import 'package:food_order_app/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB6II26cX5RCzuaE-LLv0XSJKmxFd4ZlWU",
          appId: "1:238065803705:android:027399e4857671ee37d668",
          messagingSenderId: "238065803705",
          projectId: "foodorderingapp-4d22f"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => FavoritesModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
