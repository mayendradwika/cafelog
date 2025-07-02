// lib/models/product.dart
class Product {
  final String name;
  final String imageAssetPath;
  final String description;
  final double price;
  final String cafeName;
  final double distanceKm;

  Product({
    required this.name,
    required this.imageAssetPath,
    required this.description,
    required this.price,
    required this.cafeName,
    required this.distanceKm,
  });
}
