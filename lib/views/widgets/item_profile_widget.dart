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
                  image: DecorationImage(
                    image: NetworkImage(model.avatarPath.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(model.fullName.toString()),
              subtitle: Text(model.school!.name.toString()),
            ),
          ),
        ),
    
      ],
    );
  }
}
