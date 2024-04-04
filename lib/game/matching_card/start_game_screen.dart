import 'package:beanfast_customer/game/matching_card/game_screen.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class StartGameScreen extends StatefulWidget {
  const StartGameScreen({super.key});

  @override
  State<StartGameScreen> createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Matching Game - Trò chơi trí nhớ",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          LottieBuilder.asset(
            "assets/game_assets/matching_card/brain_animation.json",
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyFlipCardGame(),
                ),
              );
            },
            child: const Text("Bắt đầu chơi",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
