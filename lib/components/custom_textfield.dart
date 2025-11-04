import 'package:flutter/material.dart';

class MyTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscuretext;
  final String text;
  final Widget suffixIcon;
  final Widget? prefixIcon;

  const MyTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscuretext,
    required this.text,
    required this.suffixIcon,
    this.prefixIcon,
  });

  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(widget.text, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextFormField(
              textAlign: TextAlign.right,
              controller: widget.controller,
              obscureText: widget.obscuretext,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffFAFAFD),
                suffixIcon: widget.suffixIcon,
                suffixIconColor: Colors.grey,
                prefixIcon: widget.prefixIcon,
                prefixIconColor: Colors.grey,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,

                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
