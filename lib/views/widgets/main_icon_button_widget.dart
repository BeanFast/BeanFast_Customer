import 'package:flutter/material.dart';

class MainIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onPressed;

  const MainIconButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
