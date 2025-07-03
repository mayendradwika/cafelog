import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product.dart';
import '../models/cafe.dart';
import 'product_detail_page.dart';
import 'cafe_detail_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Product> allProducts = [
    Product(
      name: "Caramel Macchiato",
      imageAssetPath: "assets/images/bannerslide3.jpeg",
      description: "Kombinasi espresso, susu, dan sirup karamel.",
      price: 25000,
      cafeName: "Kedai Kopi Kenangan",
      distanceKm: 1.2,
    ),
    Product(
      name: "Frappuccino",
      imageAssetPath: "assets/images/frappuccino.jpeg",
      description: "Minuman kopi dingin dengan es krim.",
      price: 22000,
      cafeName: "Espresso Bar",
      distanceKm: 2.5,
    ),
    Product(
      name: "Cappuccino",
      imageAssetPath: "assets/images/bannerslide.jpeg",
      description: "Kopi susu dengan busa susu yang lembut",
      price: 22000,
      cafeName: "Espresso Bar",
      distanceKm: 2.5,
    ),
    Product(
      name: "Boba Gong Cha",
      imageAssetPath: "assets/images/bannerslide4.jpeg",
      description: "Minuman teh susu dengan bola tapioka",
      price: 15000,
      cafeName: "Kopi Klasik",
      distanceKm: 0.8,
    ),
  ];

  final List<Cafe> allCafes = [
    Cafe(
      name: "Kedai Kopi Kenangan",
      imageAssetPath: "assets/images/cafe/cafe1.jpeg",
      description: "Gedung dengan suasana nyaman dan wifi gratis",
      distanceKm: 1.2,
    ),
    Cafe(
      name: "Espresso Bar",
      imageAssetPath: "assets/images/cafe/cafe2.jpeg",
      description: "Alat-alat kopi lengkap dan suasana modern",
      distanceKm: 2.5,
    ),
    Cafe(
      name: "Kopi Klasik",
      imageAssetPath: "assets/images/cafe/cafe3.jpeg",
      description: "Berbagai jenis kopi tradisional",
      distanceKm: 0.8,
    ),
  ];

  List<Product> filteredProducts = [];
  List<Cafe> filteredCafes = [];

  void _performSearch(String query) {
    setState(() {
      filteredProducts = allProducts
          .where((p) =>
              p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.cafeName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      filteredCafes = allCafes
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
    filteredCafes = allCafes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: TextField(
            controller: _searchController,
            onChanged: _performSearch,
            decoration: InputDecoration(
              hintText: "Cari apa nih...",
              prefixIcon: Icon(Icons.search, size: 24.sp),
              filled: true,
              fillColor: const Color.fromARGB(255, 213, 208, 255),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              if (filteredProducts.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    "Produk",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...filteredProducts.map((product) => ListTile(
                      leading: Image.asset(
                        product.imageAssetPath,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name, style: TextStyle(fontSize: 14.sp)),
                      subtitle: Text("Rp ${product.price}", style: TextStyle(fontSize: 12.sp)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: product),
                          ),
                        );
                      },
                    )),
              ],
              if (filteredCafes.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    "Tempat",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...filteredCafes.map((cafe) => ListTile(
                      leading: Image.asset(
                        cafe.imageAssetPath,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                      title: Text(cafe.name, style: TextStyle(fontSize: 14.sp)),
                      subtitle: Text("${cafe.distanceKm} km", style: TextStyle(fontSize: 12.sp)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CafeDetailPage(cafe: cafe),
                          ),
                        );
                      },
                    )),
              ],
              if (filteredProducts.isEmpty && filteredCafes.isEmpty)
                Padding(
                  padding: EdgeInsets.all(32.w),
                  child: Center(
                    child: Text(
                      "Tidak ada hasil",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
