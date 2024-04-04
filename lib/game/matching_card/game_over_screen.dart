import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatefulWidget {
  final int duration;
  const GameOverScreen({super.key, required this.duration});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  bool isConfettiPlaying = true;
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 12),
  );

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Dưới ",
                    style: theme.bodyLarge,
                    children: [
                      TextSpan(
                          text: "${widget.duration}",
                          style: theme.displaySmall),
                      TextSpan(text: " giây", style: theme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Chúc mừng bạn! ",
                    style: theme.bodyLarge,
                    children: [
                      TextSpan(
                        text:
                            "Bạn đã hoàn thành thành công trò chơi trí nhớ. Trí nhớ nhạy bén và tư duy nhanh nhạy của bạn đã giúp bạn giành chiến thắng. Hãy tiếp tục làm tốt công việc và tiếp tục thử thách bản thân khi bạn học hỏi và tiếp tục cải thiện kỹ năng của mình.",
                        style: theme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    // Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text("Hoàn thành",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            numberOfParticles: 30,
            minBlastForce: 10,
            maxBlastForce: 20,
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: _confettiController,
            gravity: 0.1,
          ),
        ],
      ),
    );
  }
}
