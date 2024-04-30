import 'package:beanfast_customer/contains/theme_color.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../models/profile.dart';

class ItemProfile extends StatelessWidget {
  final Profile model;
  final void Function() onPressed;

  const ItemProfile({super.key, required this.model, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: currentProfile.value!.id == model.id ? ThemeColor.primaryColor.withOpacity(0.3) : ThemeColor.itemColor,
                border: currentProfile.value!.id == model.id ?  Border.all(color: Colors.amber, width: 1) : null,
              ),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(model.avatarPath.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(model.fullName.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(model.school!.name.toString(),
                    style: const TextStyle(color: Colors.black54)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
