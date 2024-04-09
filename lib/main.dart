import 'package:flutter/material.dart';
import 'package:nike_shop/common/theme.dart';
import 'package:nike_shop/data/repository/auth_repository.dart';
import 'package:nike_shop/screens/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.getAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nike',
      theme: ThemeData(
        fontFamily: 'IranYekan',
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: LightThemeColors.primaryTextColor),
          bodySmall: TextStyle(color: LightThemeColors.secondaryTextColor),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: LightThemeColors.secondaryTextColor),
        ),
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
