import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 64, 231),
        foregroundColor: Colors.white,
        title: Text(product.name),
      ),
      body: Column(
        children: [
          // Gambar Produk
          Hero(
            tag: product.imageAssetPath,
            child: Image.asset(
              product.imageAssetPath,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info Produk
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black87,
                    offset: const Offset(0, -2),
                  )
                ],
              ),
              child: ListView(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Cafe dan jarak
                  Row(
                    children: [
                      const Icon(Icons.store, size: 16, color: Colors.black87),
                      const SizedBox(width: 6),
                      Text(product.cafeName),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.black87),
                      const SizedBox(width: 6),
                      Text("${product.distanceKm.toStringAsFixed(1)} km"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Harga
                  Text(
                    "Rp ${product.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 81, 64, 231)),
                  ),
                  const SizedBox(height: 16),

                  // Deskripsi
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),

      // Tombol Bawah
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Produk ditambahkan ke keranjang")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 81, 64, 231),
              iconColor: Colors.white,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text("Tambah ke Keranjang"),
          ),
        ),
      ),
    );
  }
}
