// lib/pages/search_screen.dart
import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: _performSearch,
            decoration: InputDecoration(
              hintText: "Cari apa nih...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Color.fromARGB(255, 213, 208, 255),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              if (filteredProducts.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Produk",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                ...filteredProducts.map((product) => ListTile(
                      leading: Image.asset(
                        product.imageAssetPath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text("Rp ${product.price}"),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Tempat",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                ...filteredCafes.map((cafe) => ListTile(
                      leading: Image.asset(
                        cafe.imageAssetPath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(cafe.name),
                      subtitle: Text("${cafe.distanceKm} km"),
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
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text("Tidak ada hasil")),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
