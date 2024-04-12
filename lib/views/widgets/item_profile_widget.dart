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
        Card(
          child: GestureDetector(
            onTap: onPressed,
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 1),
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
      ],
    );
  }
}
