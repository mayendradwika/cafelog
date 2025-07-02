// lib/pages/profile_tab.dart
import 'package:cafelog/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/dev.png'),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            "Mayendra Dwika",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Center(
          child: Text(
            "mayendradwikaprayudha@gmail.com",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 32),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.receipt),
          title: const Text("Riwayat Transaksi"),
          onTap: () {
            // Tambahkan aksi di sini jika perlu
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Pengaturan"),
          onTap: () {
            // Tambahkan aksi di sini jika perlu
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text("Logout", style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
        ),
      ],
    );
  }
}
