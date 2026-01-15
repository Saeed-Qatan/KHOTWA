import 'package:flutter/material.dart';
import 'package:khotwa/core/theme/app_theme.dart';
import 'package:khotwa/data/services/snackbar_services.dart';
import 'package:khotwa/view/auth/forget_page.dart';
import 'package:khotwa/view/main_view.dart';
import 'package:khotwa/view/splash_page.dart';
import 'package:khotwa/vm/auth/login_view_model.dart';
import 'package:khotwa/vm/auth/register_Info_view_model.dart';
import 'package:provider/provider.dart';

final SnackbarServices snackbarService = SnackbarServices();

void main() {
  runApp(
    Directionality(
      textDirection: TextDirection.rtl,
      child: MultiProvider(
        providers: [
          //  ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => RegisterInfoViewModel()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemeni Job Search',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      scaffoldMessengerKey: snackbarService.messengerKey,
      home: const MainView(),
    );
  }
}
