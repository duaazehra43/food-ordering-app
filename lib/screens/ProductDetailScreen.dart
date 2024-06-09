import 'package:flutter/material.dart';
import 'package:food_order_app/models/CartModel.dart';
import 'package:food_order_app/models/favModel.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String description;

  const ProductDetailScreen({
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late FavoritesModel favorites;

  @override
  void initState() {
    super.initState();
    favorites = Provider.of<FavoritesModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        actions: [
          IconButton(
            icon: Consumer<FavoritesModel>(
              builder: (context, favorites, child) {
                return Icon(
                  favorites.isFavorite(widget.title)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favorites.isFavorite(widget.title) ? Colors.red : null,
                );
              },
            ),
            onPressed: () {
              favorites.toggleFavorite({
                'image': widget.image,
                'title': widget.title,
                'price': widget.price,
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          favorites.isFavorite(widget.title)
                              ? '${widget.title} added to favorites'
                              : '${widget.title} removed from favorites',
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(10),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(widget.image),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.title,
              style: TextStyle(
                  fontFamily: 'SFProRounded',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.price,
              style: TextStyle(
                  fontFamily: 'SFProRounded',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              widget.description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false).addItem({
                    'image': widget.image,
                    'title': widget.title,
                    'price': widget.price,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 10),
                          Expanded(child: Text('Added to cart!')),
                        ],
                      ),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(10),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA4A0C),
                ),
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(
                    fontFamily: 'SFProRounded',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
