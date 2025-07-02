// lib/pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Checkout"),
          backgroundColor: const Color.fromARGB(255, 81, 64, 231),
          foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (_, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item.product.name),
                    subtitle:
                        Text("Rp ${item.product.price} x ${item.quantity}"),
                    trailing: Text(
                        "Rp ${(item.product.price * item.quantity).toStringAsFixed(0)}"),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Total: Rp ${cartProvider.totalPrice.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.clearCart();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Pembayaran Berhasil"),
                      content: const Text("Terima kasih sudah berbelanja!"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.popUntil(
                              context, (route) => route.isFirst),
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color.fromARGB(255, 81, 64, 231),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Konfirmasi Pembayaran"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
