import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/models/CartModel.dart';
import 'package:food_order_app/screens/CartScreen.dart';
import 'package:food_order_app/screens/FavoritesScreen.dart';
import 'package:food_order_app/screens/LoginScreen.dart';
import 'package:food_order_app/screens/ProductCard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(270.0),
          child: AppBar(
            backgroundColor: Colors.white,
            actions: [
              Consumer<CartModel>(
                builder: (context, cart, child) {
                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        },
                      ),
                      if (cart.items.isNotEmpty)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cart.items.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delicious\nfood for you',
                        style: TextStyle(
                          fontFamily: 'SFProRounded',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for food',
                                border: InputBorder.none,
                                icon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.red,
                    tabs: [
                      Tab(text: 'Foods'),
                      Tab(text: 'Drinks'),
                      Tab(text: 'Snacks'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            // Content for Foods Tab
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProductCard(
                    image: 'assets/images/food1.jpg',
                    title: 'Veggie Tomato Mix',
                    price: '\$10',
                    description:
                        'A delicious mix of fresh tomatoes and veggies.',
                  ),
                  ProductCard(
                    image: 'assets/images/food2.jpg',
                    title: 'Veggie Spaghetti',
                    price: '\$8',
                    description: 'Healthy spaghetti made with fresh veggies.',
                  ),
                  ProductCard(
                    image: 'assets/images/food3.jpg',
                    title: 'Kimchi Fried Rice',
                    price: '\$15',
                    description: 'Spicy and savory kimchi fried rice.',
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProductCard(
                    image: 'assets/images/drink1.jpg',
                    title: 'Lemonade',
                    price: '\$5',
                    description: 'Refreshing lemonade made with fresh lemons.',
                  ),
                  ProductCard(
                    image: 'assets/images/drink2.jpg',
                    title: 'Iced Matcha Latte',
                    price: '\$8',
                    description: 'Cool and creamy iced matcha latte.',
                  ),
                  ProductCard(
                    image: 'assets/images/drink3.jpg',
                    title: 'Iced Mocha',
                    price: '\$10',
                    description: 'Rich and chocolatey iced mocha.',
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProductCard(
                    image: 'assets/images/snack1.jpg',
                    title: 'Banana Chips',
                    price: '\$5',
                    description: 'Crispy and sweet banana chips.',
                  ),
                  ProductCard(
                    image: 'assets/images/snack2.jpg',
                    title: 'Energy Bites',
                    price: '\$8',
                    description: 'Healthy and delicious energy bites.',
                  ),
                  ProductCard(
                    image: 'assets/images/snack3.jpg',
                    title: 'Berry Yogurt Bark',
                    price: '\$10',
                    description: 'Refreshing berry yogurt bark.',
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userData = snapshot.data?.data() as Map<String, dynamic>?;

              if (userData != null) {
                final name = userData['name'] as String?;
                final email = userData['email'] as String?;

                return ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(name ?? ''),
                      accountEmail: Text(email ?? ''),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/images/profile.jpg'), // Or use NetworkImage for online image
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text('Cart'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Favorites'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritesScreen()),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Error fetching user data'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
