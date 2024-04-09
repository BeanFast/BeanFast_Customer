import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
            const SizedBox(width: 5),
            Text(
              title,
              style: Get.theme.textTheme.titleSmall!.copyWith(),
            ),
            const Spacer(),
            value != null
                ? Text(
                    value!,
                    style: Get.theme.textTheme.bodyLarge!.copyWith(
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
        child: Icon(Iconsax.arrow_right_3, color: Colors.grey),
      ),
    );
  }
}
