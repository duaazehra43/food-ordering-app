import 'package:flutter/material.dart';
import 'package:food_order_app/screens/ProductDetailScreen.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String description; // Add a description field

  const ProductCard({
    required this.image,
    required this.title,
    required this.price,
    required this.description, // Add a description parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              image: image,
              title: title,
              price: price,
              description: description, // Pass the description
            ),
          ),
        );
      },
      child: Container(
        width: 250,
        height: 300,
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          elevation: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(image),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'SFProRounded',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  price,
                  style: const TextStyle(
                      fontFamily: 'SFProRounded',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
