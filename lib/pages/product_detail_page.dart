import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          product.name,
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
      body: Column(
        children: [
          // Gambar Produk
          Hero(
            tag: product.imageAssetPath,
            child: Image.asset(
              product.imageAssetPath,
              height: 250.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info Produk
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black87.withOpacity(0.15),
                    offset: const Offset(0, -2),
                  )
                ],
              ),
              child: ListView(
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Cafe dan Jarak
                  Row(
                    children: [
                      Icon(Icons.store, size: 16.sp, color: Colors.black87),
                      SizedBox(width: 6.w),
                      Text(product.cafeName, style: TextStyle(fontSize: 14.sp)),
                      SizedBox(width: 12.w),
                      Icon(Icons.location_on,
                          size: 16.sp, color: Colors.black87),
                      SizedBox(width: 6.w),
                      Text("${product.distanceKm.toStringAsFixed(1)} km",
                          style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Harga
                  Text(
                    "Rp ${product.price.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 81, 64, 231),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Deskripsi
                  Text(
                    "Deskripsi",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 14.5.sp, height: 1.4),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),

      // Tombol Bawah
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.r)],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Produk ditambahkan ke keranjang",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 81, 64, 231),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              textStyle: TextStyle(fontSize: 16.sp),
            ),
            icon: Icon(Icons.add_shopping_cart, size: 20.sp),
            label: Text("Tambah ke Keranjang", style: TextStyle(fontSize: 16.sp)),
          ),
        ),
      ),
    );
  }
}
