 
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Color color;
  final Color textColor;
  final void Function()? onPressed;
  CustomButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),

      child: (ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: [
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(width: 5),
            icon,
          ],
        ),

        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(50),
          elevation: 10,
          shadowColor: Colors.grey,
          backgroundColor: color,
          foregroundColor: textColor,
          iconSize: 20,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        onPressed: onPressed,
      )),
    );
  }
}
