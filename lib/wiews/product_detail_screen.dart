import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  final Data product;
  final Set<int> cardIds;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cardIds,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D4263),
      appBar: AppBar(
        title: Text("Back"),
        backgroundColor: const Color(0xFF2D4263),
        leadingWidth: 20,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.id.toString(),
                child: Image.network(
                  widget.product.image ?? "",
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.make ?? "",
                      style: GoogleFonts.montserrat(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      widget.product.model ?? "",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      widget.product.year?.toString() ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade500,
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      "Description",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      widget.product.description ?? "",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "\$${widget.product.price ?? '0'}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 137, 187, 249),
                      ),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        // 1. Ana veriyi doğrudan setState içinde güncelliyoruz
                        setState(() {
                          final productId = widget.product.id;
                          if (productId != null) {
                            widget.cardIds.add(productId);
                            print(
                              "Ürün sepete eklendi. Güncel sepet boyutu: ${widget.cardIds.length}",
                            );
                          }
                        });

                        // 2. Kullanıcıya geri bildirim veriyoruz
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to cart!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black38,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
