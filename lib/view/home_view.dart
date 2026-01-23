import 'package:flutter/material.dart';
import 'package:khotwa/widgets/custom_app_bar.dart';
import 'package:khotwa/widgets/seliver_app_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MysilverAppBar(
            title: const Text('Meeting iew'),
            rightIcon: Icons.person,
            onPressedRightIcon: () {},
            leftIcon: Icons.settings,
            onPressedLeftIcon: () {},
            widget: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                textAlign: TextAlign.right, // Assuming Arabic
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'ابحث عن وظيفة أو شركة...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          SliverFillRemaining(child: const Center(child: Text('Meeting View'))),
        ],
      ),
    );
  }
}
