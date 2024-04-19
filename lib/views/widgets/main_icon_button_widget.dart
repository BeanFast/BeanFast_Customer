import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isNew;
  final void Function() onPressed;

  const MainIconButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.isNew,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      width: Get.width / 3 - 10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: Get.width / 3 - 10,
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:
                        Get.textTheme.bodyMedium!.copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
            if (isNew)
              Positioned(
                right: 20,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: const Text(
                    'New',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
