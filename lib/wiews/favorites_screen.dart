import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/products_card.dart';
import 'package:flutter_application_1/models/product_model.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Data> favoriteProducts;

  const FavoritesScreen({super.key, required this.favoriteProducts});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Local bir liste oluşturup dışarıdan gelen veriyi içine atıyoruz
  late List<Data> localFavorites;

  @override
  void initState() {
    super.initState();
    localFavorites = List.from(widget.favoriteProducts);
  }

  void toggleFavorite(Data product) {
    setState(() {
      if (localFavorites.contains(product)) {
        localFavorites.remove(product);
      } else {
        localFavorites.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Resimdeki o derin mavi-gri tonu
      backgroundColor: const Color(0xFF2D4263),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context, localFavorites),
        ),
        title: const Text(
          "My Favorites",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: localFavorites.isEmpty
          ? const Center(
              child: Text(
                "You haven't added any to your favorites yet.",
                style: TextStyle(color: Colors.white70),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: localFavorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = localFavorites[index];
                  return ProductsCard(
                    product: product,
                    isFavorite: true, // Bu ekranda hepsi favori
                    onFavoriteTap: () => toggleFavorite(product),
                  );
                },
              ),
            ),
    );
  }
}
