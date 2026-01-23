import 'package:flutter/material.dart';
import 'package:khotwa/widgets/custom_app_bar.dart';
import 'package:khotwa/widgets/seliver_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
       
      ),
      body: Center(child: Text('Profile View')),
    );
  }
}
