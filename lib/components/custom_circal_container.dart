import 'package:flutter/material.dart';

class CirticalContainer extends StatelessWidget {
  final Color color;
  final Icon icon;
  final Function onTap;
  const CirticalContainer({super.key, required this.color, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon.icon, color: color),
                      ),
    );
  }
}