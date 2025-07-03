import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/cafe.dart';

class CafeDetailPage extends StatelessWidget {
  final Cafe cafe;

  const CafeDetailPage({super.key, required this.cafe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cafe.name,
          style: TextStyle(fontSize: 20.sp),
        ),
        backgroundColor: const Color.fromARGB(255, 81, 64, 231),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Hero(
            tag: cafe.imageAssetPath,
            child: Image.asset(
              cafe.imageAssetPath,
              height: 220.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cafe.name,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey, size: 18.sp),
                    SizedBox(width: 4.w),
                    Text("${cafe.distanceKm.toStringAsFixed(1)} km",
                        style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  cafe.description,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 32.h),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Tambahkan aksi seperti "Lihat menu", dll.
                    },
                    icon: Icon(Icons.local_cafe, size: 18.sp),
                    label: Text(
                      "Lihat Menu",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
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
