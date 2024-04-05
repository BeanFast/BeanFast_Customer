import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final Future<bool> checkoutOrder;

  MyDialog({Key? key, required this.checkoutOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Checkout Order"),
      content: FutureBuilder<bool>(
        future: checkoutOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Icon(Icons.error, color: Colors.red);
            } else {
              if (snapshot.data!) {
                return Icon(Icons.check_circle, color: Colors.green);
              } else {
                return Icon(Icons.error, color: Colors.red);
              }
            }
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
