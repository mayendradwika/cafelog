import 'package:flutter/material.dart';
import '../models/cafe.dart';

class CafeDetailPage extends StatelessWidget {
  final Cafe cafe;

  const CafeDetailPage({super.key, required this.cafe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cafe.name),
        backgroundColor: Color.fromARGB(255, 81, 64, 231),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Hero(
            tag: cafe.imageAssetPath,
            child: Image.asset(
              cafe.imageAssetPath,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cafe.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${cafe.distanceKm.toStringAsFixed(1)} km"),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  cafe.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Tambahkan aksi seperti "Lihat menu", dll.
                    },
                    icon: const Icon(Icons.local_cafe),
                    label: const Text("Lihat Menu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
