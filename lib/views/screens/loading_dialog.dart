import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  final Future<dynamic> Function() future;
  final Widget child;

  const LoadingDialog({super.key, required this.future, required this.child});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: const Text("Checkout Order"),
      content: FutureBuilder(
        future: future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/images/loading.json',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Error - snapshot.hasError: ${snapshot.error}',
                style: const TextStyle(color: Colors.blue),
              ));
            } else {
              if (snapshot.data != null) {
                return child;
              } else {
                return Center(
                    child: Text(
                  'Error - else: ${snapshot.error}',
                  style: const TextStyle(color: Colors.blue),
                ));
              }
            }
          }
        },
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: const Text('Close'),
      //   ),
      // ],
    );
  }
}
