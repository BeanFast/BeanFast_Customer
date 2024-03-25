import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Future<dynamic> Function() future;
  final Widget child;

  const LoadingScreen({super.key, required this.future, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return child; // Return empty container when the data is loaded
        }
      },
    );
  }
}