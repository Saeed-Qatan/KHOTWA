import 'package:flutter/material.dart';

class MeetingView extends StatelessWidget {
  const MeetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meeting')),
      body: const Center(child: Text('Meeting View')),
    );
  }
}
