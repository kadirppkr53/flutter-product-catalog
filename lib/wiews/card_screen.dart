import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';
import 'product_detail_screen.dart';

class CardScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cardIds;

  const CardScreen({super.key, required this.cardIds, required this.products});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  double get totalAmount {
    double total = 0;
    final cartProducts = widget.products
        .where((p) => widget.cardIds.contains(p.id))
        .toList();
    for (var item in cartProducts) {
      total += double.tryParse(item.price.toString()) ?? 0.0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((p) => widget.cardIds.contains(p.id))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF2D4263),
      appBar: AppBar(
        title: const Text("Card"),
        backgroundColor: const Color(0xFF2D4263),
        leadingWidth: 20,
        actions: [
          if (cartProducts.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  widget.cardIds.clear();
                });
              },
              child: Row(
                children: [
                  Text(
                    "Clear All",
                    style: TextStyle(
                      color: Color(0xFFD3D3D3),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.delete_forever_rounded,
                    color: Color(0xFFD3D3D3),
                    size: 28,
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                            const SizedBox(height: 12),
                            Text(
                              "Your cards is empty.",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Click the button to start shopping.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 24),
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

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    product: item,
                                    cardIds: widget.cardIds,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
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
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.make ?? "",
                                          style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          item.model ?? "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "\$${item.price.toString()}",
                                          style: const TextStyle(
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
                                    icon: const Icon(
                                      Icons.restore_from_trash_rounded,
                                    ),
                                    color: const Color(0xFFD3D3D3),
                                    iconSize: 28,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (cartProducts.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "\$${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),

              if (cartProducts.isNotEmpty)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black38,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    "Complete payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
