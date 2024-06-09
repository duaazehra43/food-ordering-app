import 'package:flutter/material.dart';
import 'package:food_order_app/models/favModel.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favorites.items.isEmpty
          ? Center(
              child: Text(
              'No favorites added!\n Delicious Food is waiting for you.',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'SFProRounded',
              ),
            ))
          : ListView.builder(
              itemCount: favorites.items.length,
              itemBuilder: (context, index) {
                final item = favorites.items[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(item['image']!),
                  ),
                  title: Text(item['title']!),
                  subtitle: Text(item['price']!),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      favorites.removeItem(item);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: Colors.white),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                    '${item['title']} removed from favorites'),
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
                );
              },
            ),
    );
  }
}
