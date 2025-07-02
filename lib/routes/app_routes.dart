import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../pages/home_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';

  static final routes = <String, WidgetBuilder>{
    login: (_) => LoginScreen(),
    home: (_) => HomeScreen(),
  };
}
