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
                child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final item = cartProducts[index];

                    return Row(
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
                      ],
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
