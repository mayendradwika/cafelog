import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cafe.dart';
import '../providers/cart_provider.dart';
import 'product_detail_page.dart';
import 'cart_page.dart';
import 'cafe_detail_page.dart';
import '../pages/profile_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Product> products = [
    Product(
      name: "Caramel Macchiato",
      imageAssetPath: "assets/images/bannerslide3.jpeg",
      description: "Kombinasi espresso, susu, dan sirup karamel.",
      price: 25000,
      cafeName: "Kopi Kenangan",
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

  final List<Cafe> cafes = [
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

  final List<String> bannerImages = [
    'assets/images/bannerslide.jpeg',
    'assets/images/bannerslide1.jpeg',
    'assets/images/bannerslide2.jpeg',
    'assets/images/bannerslide3.jpeg',
    'assets/images/bannerslide4.jpeg',
  ];

  late PageController _bannerController;
  int _currentBannerPage = 0;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    _bannerController = PageController(initialPage: 0);

    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        _currentBannerPage++;
        if (_currentBannerPage >= bannerImages.length) _currentBannerPage = 0;
        _bannerController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 1100),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildHomeTab() {
    return ListView(
      children: [
        // Auto-scrolling Banner Slider
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bannerImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        // Saldo dan shortcut
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 213, 208, 255),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSaldoItem(
                Icons.account_balance_wallet,
                "Saldo",
                "Rp 50.000",
              ),
              _buildSaldoItem(
                Icons.arrow_upward,
                "Top Up",
                "",
              ),
              _buildSaldoItem(
                Icons.qr_code,
                "Bayar",
                "",
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),
// Produk Horizontal Scroll
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Minuman spesial hari ini",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () => _openProduct(product),
                child: Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12.r)),
                        child: Image.asset(
                          product.imageAssetPath,
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Rp ${product.price}",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 81, 64, 231),
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Promo menarik buat kamu",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 120.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  'assets/images/promo/promo5.jpeg',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  'assets/images/promo/promo2.jpeg',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  'assets/images/promo/promo3.jpeg',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Cek yang menarik di CafeLog",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(height: 12.h),

        SizedBox(
          height: 160.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              _buildPromoBanner('assets/images/bannerslide3.jpeg'),
              SizedBox(width: 12.w),
              _buildPromoBanner('assets/images/bannerslide2.jpeg'),
            ],
          ),
        ),

        // Produk Vertical List

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Menu Favorit",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildFavoriteCard(product, () => _openProduct(product));
          },
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Ada yang baru nih",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 180.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            children: [
              _buildPromoBanner("assets/images/bannerslide1.jpeg"),
              _buildPromoBanner("assets/images/bannerslide.jpeg"),
            ],
          ),
        ),

        // List Cafe
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Text(
            "Tempat nongki paling oke",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          itemCount: cafes.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          itemBuilder: (context, index) {
            final cafe = cafes[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CafeDetailPage(cafe: cafe)),
              ),
              child: Card(
                margin: EdgeInsets.only(bottom: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                      child: Image.asset(
                        cafe.imageAssetPath,
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cafe.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 14.sp),
                                SizedBox(width: 4.w),
                                Text("${cafe.distanceKm} km",
                                    style: TextStyle(fontSize: 14.sp)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text("Special menu ",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        ),

        SizedBox(
          width: 300.w,
          height: 160.h,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, // Warna border
                width: 10.0.w, // Ketebalan border
              ),
              borderRadius:
                  BorderRadius.circular(12.r), // Optional: bikin sudut membulat
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  19.r), // Cocokkan dengan borderRadius di atas
              child: Image.asset(
                'assets/images/banner1.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        SizedBox(
          width: 300.w,
          height: 160.h,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, // Warna border
                width: 10.0.w, // Ketebalan border
              ),
              borderRadius:
                  BorderRadius.circular(12.r), // Optional: bikin sudut membulat
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  19.r), // Cocokkan dengan borderRadius di atas
              child: Image.asset(
                'assets/images/banner.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
    );
  }

  Widget _buildSaldoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.black87),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.black87)),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildPromoBanner(String imagePath) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 10.w,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19.r),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(Product product, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                product.imageAssetPath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("Rp ${product.price}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 81, 64, 231))),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.store, size: 14),
                        const SizedBox(width: 4),
                        Text(product.cafeName),
                        const SizedBox(width: 12),
                        const Icon(Icons.location_on, size: 14),
                        const SizedBox(width: 4),
                        Text("${product.distanceKm} km"),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CafeLog",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 81, 64, 231),
        foregroundColor: Colors.white,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cartProvider.totalItems > 0)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '${cartProvider.totalItems}',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartPage())),
              );
            },
          )
        ],
      ),
      body: _selectedIndex == 0
          ? buildHomeTab()
          : _selectedIndex == 1
              ? const SearchScreen()
              : _selectedIndex == 2
                  ? const ProfileTab()
                  : const Center(child: Text("Fitur lain dalam pengembangan")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 81, 64, 231),
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
