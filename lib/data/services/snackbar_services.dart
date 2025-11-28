import 'package:flutter/material.dart';

class SnackbarServices {
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(dynamic message, Color color) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: color,
        animation: Animation.fromValueListenable(ValueNotifier<double>(6.0)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
