import 'package:flutter/material.dart';
import 'package:khotwa/view/SplashScreen.dart';

  void main() {
    runApp(Directionality(textDirection: TextDirection.rtl, child: MyApp()));
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemeni Job Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Cairo'),
      home: const SplashScreen(),
    );
  }
}
