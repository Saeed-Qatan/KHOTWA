import 'package:flutter/material.dart';
import 'package:khotwa/widgets/seliver_app_bar.dart';

class MeetingView extends StatelessWidget {
  const MeetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MysilverAppBar(title: const Text('Meeting iew')),
          SliverFillRemaining(child: const Center(child: Text('Meeting View'))),
        ],
      ),
    );
  }
}
