import 'package:flutter/material.dart';
import 'package:food_order_app/screens/LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFF4B3A),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.05,
                ),
                Image.asset(
                  "assets/images/splash_logo.png",
                  width: size.width * 0.15,
                  height: size.height * 0.15,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.05,
                ),
                Text(
                  "Food For \nEveryone",
                  style: TextStyle(
                      fontFamily: 'SFProRounded',
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            Container(
              width: size.width * 1.5,
              height: isPortrait ? size.height * 0.5 : size.height * 0.7,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/splash_faces.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(
              width: size.width * 0.6,
              height: size.height * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontFamily: 'SFProRounded',
                    fontSize: size.width * 0.05,
                    color: const Color(0xFFFF4B3A),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
