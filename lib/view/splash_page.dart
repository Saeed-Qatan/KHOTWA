import 'package:flutter/material.dart';
import 'package:khotwa/core/navigations/navigations.dart';
import 'package:khotwa/view/auth/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      AppNavigation.pushAndRemove(context, LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.apartment, size: 80, color: Color(0xFF42A5F5)),
            const SizedBox(height: 20),
            Text(
              'Yemen Jobs',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'فرصتك تبدأ من هنا',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF42A5F5),
                  ),
                  minHeight: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
