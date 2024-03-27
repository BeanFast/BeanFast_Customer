import 'package:flutter/material.dart';

class RowInfoItemWidget extends StatelessWidget {
  const RowInfoItemWidget({super.key, required this.titel, required this.data});
  final String titel;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            child: Text(
          titel,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        )),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
