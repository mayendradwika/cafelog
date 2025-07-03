import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          "Keranjang",
          style: TextStyle(fontSize: 20.sp),
        ),
        backgroundColor: const Color.fromARGB(255, 81, 64, 231),
        foregroundColor: Colors.white,
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(
              child: Text(
                "Keranjang kosong",
                style: TextStyle(fontSize: 16.sp),
              ),
            )
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return ListTile(
                  leading: Image.asset(
                    item.product.imageAssetPath,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    item.product.name,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  subtitle: Text(
                    "Qty: ${item.quantity}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  trailing: Text(
                    "Rp ${(item.product.price * item.quantity).toStringAsFixed(0)}",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartProvider.cartItems.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4.r)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp ${cartProvider.totalPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: cartProvider.cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CheckoutPage()),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 81, 64, 231),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18.sp),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Checkout",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
