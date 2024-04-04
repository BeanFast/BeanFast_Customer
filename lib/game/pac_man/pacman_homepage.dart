import 'dart:async';
import 'dart:math';

import 'package:beanfast_customer/game/pac_man/ghost.dart';
import 'package:beanfast_customer/game/pac_man/ghost2.dart';
import 'package:beanfast_customer/game/pac_man/ghost3.dart';
import 'package:beanfast_customer/game/pac_man/path.dart';
import 'package:beanfast_customer/game/pac_man/pixel.dart';
import 'package:beanfast_customer/game/pac_man/player.dart';
import 'package:flutter/material.dart';

class PacmanGame extends StatefulWidget {
  const PacmanGame({super.key});

  @override
  _PacmanGameState createState() => _PacmanGameState();
}

class _PacmanGameState extends State<PacmanGame> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  int player = numberInRow * 14 + 1;
  int ghost = numberInRow * 2 - 2;
  int ghost2 = numberInRow * 9 - 1;
  int ghost3 = numberInRow * 11 - 2;
  bool preGame = true;
  bool mouthClosed = false;
  var controller;
  int score = 0;
  bool paused = false;
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,
    134,
    145,
    129,
    140,
    151,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
  ];
  List<int> food = [];
  String direction = "right";
  String ghostLast = "left";
  String ghostLast2 = "left";
  String ghostLast3 = "down";
  late Timer ghostTimer;
  late Timer playerTimer;

  void startGame() {
    if (preGame) {
      preGame = false;
      getFood();

      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        if (!mounted) return;
        if (paused) {
        } else {}
        if (player == ghost || player == ghost2 || player == ghost3) {
           if (!mounted) return;
          setState(() {
            player = -1;
          });
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text("Game Over!")),
                  content: Text(
                    "Điểm của bạn: $score",
                    style: const TextStyle(fontSize: 16),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        if (!mounted) return;
                        setState(() {
                          player = numberInRow * 14 + 1;
                          ghost = numberInRow * 2 - 2;
                          ghost2 = numberInRow * 9 - 1;
                          ghost3 = numberInRow * 11 - 2;
                          paused = false;
                          preGame = false;
                          mouthClosed = false;
                          direction = "right";
                          food.clear();
                          getFood();
                          score = 0;
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.3), // Change this color to your desired one
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text(
                          "Chơi lại",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              });
        }
      });
      //ghost
      ghostTimer = Timer.periodic(const Duration(milliseconds: 290), (timer) {
        if (!mounted) return;
        if (!paused) {
          moveGhost();
          moveGhost2();
          moveGhost3();
        }
      });
      //player
      playerTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        if (!mounted) return;
        setState(() {
          mouthClosed = !mouthClosed;
        });
        if (food.contains(player)) {
          setState(() {
            food.remove(player);
          });
          score++;
        }

        switch (direction) {
          case "left":
            if (!paused) moveLeft();
            break;
          case "right":
            if (!paused) moveRight();
            break;
          case "up":
            if (!paused) moveUp();
            break;
          case "down":
            if (!paused) moveDown();
            break;
        }
      });
    }
  }

  void restart() {
    startGame();
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  void moveGhost() {
    switch (ghostLast) {
      case "left":
        if (!barriers.contains(ghost - 1)) {
          setState(() {
            ghost--;
          });
        } else {
          if (!barriers.contains(ghost + numberInRow)) {
            setState(() {
              ghost += numberInRow;
              ghostLast = "down";
            });
          } else if (!barriers.contains(ghost + 1)) {
            setState(() {
              ghost++;
              ghostLast = "right";
            });
          } else if (!barriers.contains(ghost - numberInRow)) {
            setState(() {
              ghost -= numberInRow;
              ghostLast = "up";
            });
          }
        }
        break;
      case "right":
        if (!barriers.contains(ghost + 1)) {
          setState(() {
            ghost++;
          });
        } else {
          if (!barriers.contains(ghost - numberInRow)) {
            setState(() {
              ghost -= numberInRow;
              ghostLast = "up";
            });
          } else if (!barriers.contains(ghost + numberInRow)) {
            setState(() {
              ghost += numberInRow;
              ghostLast = "down";
            });
          } else if (!barriers.contains(ghost - 1)) {
            setState(() {
              ghost--;
              ghostLast = "left";
            });
          }
        }
        break;
      case "up":
        if (!barriers.contains(ghost - numberInRow)) {
          setState(() {
            ghost -= numberInRow;
            ghostLast = "up";
          });
        } else {
          if (!barriers.contains(ghost + 1)) {
            setState(() {
              ghost++;
              ghostLast = "right";
            });
          } else if (!barriers.contains(ghost - 1)) {
            setState(() {
              ghost--;
              ghostLast = "left";
            });
          } else if (!barriers.contains(ghost + numberInRow)) {
            setState(() {
              ghost += numberInRow;
              ghostLast = "down";
            });
          }
        }
        break;
      case "down":
        if (!barriers.contains(ghost + numberInRow)) {
          setState(() {
            ghost += numberInRow;
            ghostLast = "down";
          });
        } else {
          if (!barriers.contains(ghost - 1)) {
            setState(() {
              ghost--;
              ghostLast = "left";
            });
          } else if (!barriers.contains(ghost + 1)) {
            setState(() {
              ghost++;
              ghostLast = "right";
            });
          } else if (!barriers.contains(ghost - numberInRow)) {
            setState(() {
              ghost -= numberInRow;
              ghostLast = "up";
            });
          }
        }
        break;
    }
  }

  void moveGhost2() {
    switch (ghostLast2) {
      case "left":
        if (!barriers.contains(ghost2 - 1)) {
          setState(() {
            ghost2--;
          });
        } else {
          if (!barriers.contains(ghost2 + numberInRow)) {
            setState(() {
              ghost2 += numberInRow;
              ghostLast2 = "down";
            });
          } else if (!barriers.contains(ghost2 + 1)) {
            setState(() {
              ghost2++;
              ghostLast2 = "right";
            });
          } else if (!barriers.contains(ghost2 - numberInRow)) {
            setState(() {
              ghost2 -= numberInRow;
              ghostLast2 = "up";
            });
          }
        }
        break;
      case "right":
        if (!barriers.contains(ghost2 + 1)) {
          setState(() {
            ghost2++;
          });
        } else {
          if (!barriers.contains(ghost2 - numberInRow)) {
            setState(() {
              ghost2 -= numberInRow;
              ghostLast2 = "up";
            });
          } else if (!barriers.contains(ghost2 + numberInRow)) {
            setState(() {
              ghost2 += numberInRow;
              ghostLast2 = "down";
            });
          } else if (!barriers.contains(ghost2 - 1)) {
            setState(() {
              ghost2--;
              ghostLast2 = "left";
            });
          }
        }
        break;
      case "up":
        if (!barriers.contains(ghost2 - numberInRow)) {
          setState(() {
            ghost2 -= numberInRow;
            ghostLast2 = "up";
          });
        } else {
          if (!barriers.contains(ghost2 + 1)) {
            setState(() {
              ghost2++;
              ghostLast2 = "right";
            });
          } else if (!barriers.contains(ghost2 - 1)) {
            setState(() {
              ghost2--;
              ghostLast2 = "left";
            });
          } else if (!barriers.contains(ghost2 + numberInRow)) {
            setState(() {
              ghost2 += numberInRow;
              ghostLast2 = "down";
            });
          }
        }
        break;
      case "down":
        if (!barriers.contains(ghost2 + numberInRow)) {
          setState(() {
            ghost2 += numberInRow;
            ghostLast2 = "down";
          });
        } else {
          if (!barriers.contains(ghost2 - 1)) {
            setState(() {
              ghost2--;
              ghostLast2 = "left";
            });
          } else if (!barriers.contains(ghost2 + 1)) {
            setState(() {
              ghost2++;
              ghostLast2 = "right";
            });
          } else if (!barriers.contains(ghost2 - numberInRow)) {
            setState(() {
              ghost2 -= numberInRow;
              ghostLast2 = "up";
            });
          }
        }
        break;
    }
  }

  void moveGhost3() {
    switch (ghostLast) {
      case "left":
        if (!barriers.contains(ghost3 - 1)) {
          setState(() {
            ghost3--;
          });
        } else {
          if (!barriers.contains(ghost3 + numberInRow)) {
            setState(() {
              ghost3 += numberInRow;
              ghostLast3 = "down";
            });
          } else if (!barriers.contains(ghost3 + 1)) {
            setState(() {
              ghost3++;
              ghostLast3 = "right";
            });
          } else if (!barriers.contains(ghost3 - numberInRow)) {
            setState(() {
              ghost3 -= numberInRow;
              ghostLast3 = "up";
            });
          }
        }
        break;
      case "right":
        if (!barriers.contains(ghost3 + 1)) {
          setState(() {
            ghost3++;
          });
        } else {
          if (!barriers.contains(ghost3 - numberInRow)) {
            setState(() {
              ghost3 -= numberInRow;
              ghostLast3 = "up";
            });
          } else if (!barriers.contains(ghost3 - 1)) {
            setState(() {
              ghost3--;
              ghostLast3 = "left";
            });
          } else if (!barriers.contains(ghost3 + numberInRow)) {
            setState(() {
              ghost3 += numberInRow;
              ghostLast3 = "down";
            });
          }
        }
        break;
      case "up":
        if (!barriers.contains(ghost3 - numberInRow)) {
          setState(() {
            ghost3 -= numberInRow;
            ghostLast3 = "up";
          });
        } else {
          if (!barriers.contains(ghost3 + 1)) {
            setState(() {
              ghost3++;
              ghostLast3 = "right";
            });
          } else if (!barriers.contains(ghost3 - 1)) {
            setState(() {
              ghost3--;
              ghostLast3 = "left";
            });
          } else if (!barriers.contains(ghost3 + numberInRow)) {
            setState(() {
              ghost3 += numberInRow;
              ghostLast3 = "down";
            });
          }
        }
        break;
      case "down":
        if (!barriers.contains(ghost3 + numberInRow)) {
          setState(() {
            ghost3 += numberInRow;
            ghostLast3 = "down";
          });
        } else {
          if (!barriers.contains(ghost3 - 1)) {
            setState(() {
              ghost3--;
              ghostLast3 = "left";
            });
          } else if (!barriers.contains(ghost3 + 1)) {
            setState(() {
              ghost3++;
              ghostLast3 = "right";
            });
          } else if (!barriers.contains(ghost3 - numberInRow)) {
            setState(() {
              ghost3 -= numberInRow;
              ghostLast3 = "up";
            });
          }
        }
        break;
    }
  }

  @override
  void dispose() {
    ghostTimer.cancel();
    playerTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PacMan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 20),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInRow),
                itemBuilder: (BuildContext context, int index) {
                  if (mouthClosed && player == index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                      ),
                    );
                  } else if (player == index) {
                    switch (direction) {
                      case "left":
                        return Transform.rotate(
                          angle: pi,
                          child: MyPlayer(),
                        );
                      case "right":
                        return MyPlayer();
                      case "up":
                        return Transform.rotate(
                          angle: 3 * pi / 2,
                          child: MyPlayer(),
                        );
                      case "down":
                        return Transform.rotate(
                          angle: pi / 2,
                          child: MyPlayer(),
                        );
                      default:
                        return MyPlayer();
                    }
                  } else if (ghost == index) {
                    return const MyGhost();
                  } else if (ghost2 == index) {
                    return const MyGhost2();
                  } else if (ghost3 == index) {
                    return const MyGhost3();
                  } else if (barriers.contains(index)) {
                    return MyPixel(
                      innerColor: Colors.blue[900],
                      outerColor: Colors.blue[800],
                    );
                  } else if (preGame || food.contains(index)) {
                    return const MyPath(
                      innerColor: Colors.yellow,
                      outerColor: Colors.black,
                    );
                  } else {
                    return const MyPath(
                      innerColor: Colors.black,
                      outerColor: Colors.black,
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  " Điểm: $score",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                GestureDetector(
                  onTap: startGame,
                  child: const Text(
                    "P L A Y",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    paused == true ? Icons.pause : Icons.play_arrow,
                    size: 35,
                    color: Colors.white,
                  ),
                  onTap: () => {
                    paused = !paused,
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
