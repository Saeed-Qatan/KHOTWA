import 'package:flutter/material.dart';

import 'package:khotwa/view/home_page.dart';
import 'package:khotwa/view/meeting_view.dart';
import 'package:khotwa/view/orders_view.dart';
import 'package:khotwa/view/profile_view.dart';
import 'package:khotwa/view/search_view.dart';
import 'package:khotwa/widgets/custom_app_bar.dart';
import 'package:khotwa/widgets/custom_bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SearchView(),
    const OrdersView(),
    const MeetingView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
