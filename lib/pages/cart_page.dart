import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text("Keranjang"),
          backgroundColor: const Color.fromARGB(255, 81, 64, 231),
          foregroundColor: Colors.white),
      body: cartProvider.cartItems.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return ListTile(
                  leading: Image.asset(item.product.imageAssetPath,
                      width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(item.product.name),
                  subtitle: Text("Qty: ${item.quantity}"),
                  trailing: Text(
                      "Rp ${(item.product.price * item.quantity).toStringAsFixed(0)}"),
                );
              },
            ),
      bottomNavigationBar: cartProvider.cartItems.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Rp ${cartProvider.totalPrice.toStringAsFixed(0)}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: cartProvider.cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckoutPage(),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 81, 64, 231),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(child: Text("Checkout")),
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
