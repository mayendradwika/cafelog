import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'pages/home_screen.dart';
import '/features/auth/screens/login_screen.dart';
import 'package:cafelog/pages/intro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CafeLogApp());
}

class CafeLogApp extends StatelessWidget {
  const CafeLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // ukuran desain dari Figma atau referensi utama
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'CafeLog',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.deepPurple),
            initialRoute: '/',
            routes: {
              '/': (context) => const WelcomeScreen(),
              '/login': (context) => LoginScreen(),
              '/home': (context) => const HomeScreen(),
            },
          );
        },
      ),
    );
  }
}
