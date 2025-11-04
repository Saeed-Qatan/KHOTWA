import 'package:flutter/material.dart';

class CirticalContainter extends StatelessWidget {
  final Color color;
  final Icon icon;
  const CirticalContainter({super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(100),
                    
                  ),

                  child: Icon(
                    icon.icon,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
    );
  }
}