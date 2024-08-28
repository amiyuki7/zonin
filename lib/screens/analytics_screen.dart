import 'package:backend/models/user.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  final User user;
  const AnalyticsScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Analytics Page'),
          Text('Logged in as ${user.email}'),
          Text('id=${user.id}'),
        ],
      ),
    );
  }
}
