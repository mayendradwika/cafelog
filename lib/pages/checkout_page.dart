import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          "Checkout",
          style: TextStyle(fontSize: 20.sp),
        ),
        backgroundColor: const Color.fromARGB(255, 81, 64, 231),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (_, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(
                      item.product.name,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    subtitle: Text(
                      "Rp ${item.product.price} x ${item.quantity}",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    trailing: Text(
                      "Rp ${(item.product.price * item.quantity).toStringAsFixed(0)}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Total: Rp ${cartProvider.totalPrice.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.clearCart();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        "Pembayaran Berhasil",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      content: Text(
                        "Terima kasih sudah berbelanja!",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            "OK",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          onPressed: () => Navigator.popUntil(
                              context, (route) => route.isFirst),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  backgroundColor: const Color.fromARGB(255, 81, 64, 231),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18.sp),
                ),
                child: Text(
                  "Konfirmasi Pembayaran",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
