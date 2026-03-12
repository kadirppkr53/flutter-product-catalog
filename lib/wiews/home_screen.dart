import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/products_card.dart';
import 'package:flutter_application_1/models/product_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/wiews/card_screen.dart';
import 'package:flutter_application_1/wiews/favorites_screen.dart';
import 'package:flutter_application_1/wiews/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  String erroMessage = "";
  List<Data> allProducts = [];
  List<Data> favoriteList = [];
  ApiService apiService = ApiService();
  final Set<int> cardIds = {};

  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      ProductModel resData = await apiService.fetchProducts();

      setState(() {
        allProducts = resData.data ?? [];
      });
    } catch (e) {
      setState(() {
        erroMessage = "Failed to load products";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleFavorite(Data product) {
    setState(() {
      if (favoriteList.contains(product)) {
        favoriteList.remove(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${product.make} Removed from favorites!")),
        );
      } else {
        favoriteList.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${product.make} Added to favorites!")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(219, 69, 97, 148),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardScreen(
                            products: allProducts,
                            cardIds: cardIds,
                          ),
                        ),
                      );
                    },
                    iconSize: 32,
                    icon: const Icon(Icons.shopping_bag_rounded),
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Dream Garage",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // Favori ekranına gider ve oradan dönen güncel listeyi bekler
                      final List<Data>? updatedList = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FavoritesScreen(favoriteProducts: favoriteList),
                        ),
                      );

                      // Eğer geri dönüldüğünde liste güncellenmişse state'i yeniler
                      if (updatedList != null) {
                        setState(() {
                          favoriteList = updatedList;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 213, 94, 85),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 217, 217),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Explore models",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 149, 146, 146),
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 85.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage("images/banner.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (erroMessage != "")
                Center(child: Text(erroMessage))
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: allProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                    itemBuilder: (context, index) {
                      final product = allProducts[index];
                      bool isFavorite = favoriteList.contains(product);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                cardIds: cardIds,
                              ),
                            ),
                          );
                        },
                        child: ProductsCard(
                          product: product,
                          isFavorite: isFavorite,
                          onFavoriteTap: () => toggleFavorite(product),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
