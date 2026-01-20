import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Stack(
        children: [
          // 1. Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF225CE4), // Lighter Blue
                  Color(0xFF1D4ED7), // Darker Blue
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),

          // 2. Decorative Circles
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          

          // // 3. Content
          // SafeArea(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 20.0,
          //       vertical: 10,
          //     ),
          //     child: Column(
          //       children: [
          //         // Top Row
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             // Settings Icon (Left)
          //             Container(
          //               padding: const EdgeInsets.all(8),
          //               decoration: BoxDecoration(
          //                 color: Colors.white.withOpacity(0.2),
          //                 shape: BoxShape.circle,
          //               ),
          //               child: const Icon(Icons.settings, color: Colors.white),
          //             ),

          //             // Greeting Text (Center/Right-ish)

          //             // Profile Picture (Right)
          //             Container(
          //               padding: const EdgeInsets.all(8),
          //               decoration: BoxDecoration(
          //                 color: Colors.white.withOpacity(0.2),
          //                 shape: BoxShape.circle,
          //               ),
          //               child: const Icon(Icons.person, color: Colors.white),
          //             ),
          //           ],
          //         ),

          //         const SizedBox(height: 20),

          //         // Search Bar
          //         Container(
          //           height: 50,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //           child: const TextField(
          //             textAlign: TextAlign.right, // Assuming Arabic
          //             textDirection: TextDirection.rtl,
          //             decoration: InputDecoration(
          //               hintText: 'ابحث عن وظيفة أو شركة...',
          //               hintStyle: TextStyle(color: Colors.grey),
          //               prefixIcon: Icon(Icons.search, color: Colors.grey),
          //               border: InputBorder.none,
          //               contentPadding: EdgeInsets.symmetric(vertical: 15),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(180);
}
