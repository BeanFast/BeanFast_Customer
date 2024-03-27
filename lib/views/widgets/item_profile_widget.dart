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
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(model.fullName.toString()),
            subtitle: Text(model.school!.name.toString()),
          ),
        ),
        const Divider(),
      ],
    );
  }
}