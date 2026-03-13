import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';

class CardScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cardIds;

  const CardScreen({super.key, required this.cardIds, required this.products});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    // 1. Önce listeni bir kez tanımla
    final cartProducts = widget.products
        .where((p) => widget.cardIds.contains(p.id))
        .toList();

    // 2. Şimdi loglarını buraya yazdır (hata vermez)
    print("DEBUG: Toplam Ürün: ${widget.products.length}");
    print("DEBUG: Sepetteki ID Sayısı: ${widget.cardIds.length}");
    print(
      "DEBUG: Filtrelenmiş (Sepetteki) Ürün Sayısı: ${cartProducts.length}",
    );

    return Scaffold(
      backgroundColor: Color(0xFF2D4263),
      appBar: AppBar(
        title: Text("Card"),
        backgroundColor: Color(0xFF2D4263),
        leadingWidth: 20,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: 64,
                              color: Colors.blueGrey.shade200,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Your cards is empty.",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Click the button to start shopping.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade700,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                "Start shopping",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final item = cartProducts[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(item.image ?? ""),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.make ?? "",
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        item.model ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "\$${item.price.toString()}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.cardIds.remove(item.id);
                                    });
                                  },
                                  icon: Icon(Icons.restore_from_trash_rounded),
                                  color: Color(0xFFD3D3D3),
                                  iconSize: 28,
                                ),
                              ],
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
