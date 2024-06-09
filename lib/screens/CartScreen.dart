import 'package:flutter/material.dart';
import 'package:food_order_app/models/CartModel.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty. \nAdd delicious food to cart!',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SFProRounded',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(item['image']!),
                        ),
                        title: Text(item['title']!),
                        subtitle: Text(item['price']!),
                      );
                    },
                  ),
          ),
          if (cart.items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${cart.totalAmount}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      cart.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 10),
                              Expanded(child: Text('Order completed!')),
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
                    child: const Text('Complete Order'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
