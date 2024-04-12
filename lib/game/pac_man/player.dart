// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset(
        'assets/game_assets/pac_man/pacman.png',
        // width: MediaQuery.of(context).size.width,
        // fit: BoxFit.cover,
      ),
    );
  }
}
