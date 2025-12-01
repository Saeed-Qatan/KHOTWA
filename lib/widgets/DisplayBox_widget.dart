import 'package:flutter/material.dart';

class DisplayBoxWidget extends StatelessWidget {
  final Widget child;
  const DisplayBoxWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      // height removed to allow dynamic sizing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xff1F59DF),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
