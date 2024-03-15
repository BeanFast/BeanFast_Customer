import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function() onTap;
  final String? value;
  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            value != null
                ? Text(
                    value!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 20),
            ForwardButton(
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class ForwardButton extends StatelessWidget {
  final Function() onTap;
  const ForwardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const SizedBox(
        width: 50,
        height: 50,
        child: Icon(Ionicons.chevron_forward_outline),
      ),
    );
  }
}