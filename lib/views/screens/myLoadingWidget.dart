import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class MyLoadingWidget extends StatelessWidget {
  const MyLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      future: () {
        return Future.delayed(const Duration(seconds: 10000), () => 'Hello');
      },
      child: Text('Hello'),
    );
  }
}
