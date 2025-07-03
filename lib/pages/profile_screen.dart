import 'package:cafelog/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        Center(
          child: CircleAvatar(
            radius: 50.r,
            backgroundImage: const AssetImage('assets/images/dev.png'),
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: Text(
            "Mayendra Dwika",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            "mayendradwikaprayudha@gmail.com",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(height: 32.h),
        Divider(thickness: 1.h),
        ListTile(
          leading: Icon(Icons.receipt, size: 24.sp),
          title: Text(
            "Riwayat Transaksi",
            style: TextStyle(fontSize: 16.sp),
          ),
          onTap: () {
            // Tambahkan aksi di sini jika perlu
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, size: 24.sp),
          title: Text(
            "Pengaturan",
            style: TextStyle(fontSize: 16.sp),
          ),
          onTap: () {
            // Tambahkan aksi di sini jika perlu
          },
        ),
        Divider(thickness: 1.h),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red, size: 24.sp),
          title: Text(
            "Logout",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
            ),
          ),
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
