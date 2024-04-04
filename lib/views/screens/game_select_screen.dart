import 'package:beanfast_customer/game/matching_card/start_game_screen.dart';
import 'package:beanfast_customer/game/pac_man/pacman_homepage.dart';
import 'package:beanfast_customer/game/tetris/board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameSelectScreen extends StatelessWidget {
  const GameSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //List<Game> games = [];
    List<Game> games = [
      Game(
        name: 'Matching Game - Trò chơi trí nhớ',
        shortDescription:
            'trò chơi trí nhớ đơn giản nhưng đầy thú vị, phù hợp với mọi lứa tuổi. Trò chơi này giúp rèn luyện khả năng ghi nhớ, tập trung và phân biệt hình ảnh.',
        image:
            'https://img.kwcdn.com/product/open/2023-12-13/1702469460222-0d8533f2967848f485a9eb3c287c883e-goods.jpeg?imageMogr2/auto-orient%7CimageView2/2/w/800/q/70/format/webp',
        onClick: () {
          Get.to(const StartGameScreen());
        },
      ),
      Game(
        name: 'Pac-Man',
        shortDescription:
            'Pac-Man là một trò chơi đơn giản nhưng đầy thử thách, phù hợp với mọi lứa tuổi. Trò chơi giúp rèn luyện khả năng phối hợp tay mắt, phản xạ nhanh nhạy và khả năng tập trung.',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Pac_Man.svg/800px-Pac_Man.svg.png',
        onClick: () {
          Get.to(const PacmanGame());
        },
      ),
      Game(
        name: 'Tetris - Xếp hình',
        shortDescription:
            'Tetris là một trò chơi xếp hình kinh điển, nơi bạn điều khiển các khối hình vuông rơi xuống, gọi là tetrominoes, để sắp xếp chúng thành các hàng ngang hoàn chỉnh. ',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGs3JwFghtgDy5oy9HPWl794T3CGBHKvaELV9xsi2KJg&s',
        onClick: () {
          Get.to(const GameBoard());
        },
      ),
    ];
    //UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trò chơi'),
        actions: [
          Container(
            width: 170,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.card_giftcard, color: Colors.black),
                Text('Điểm: 100.000'),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            games.length,
            (index) => GestureDetector(
              onTap: () {
                games[index].onClick();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 5),
                child: Card(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                child: Image.network(
                                  games[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, right: 10, bottom: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        games[index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Text(
                                          games[index].shortDescription,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black45),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 10),
                              child: TextButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(5)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  games[index].onClick();
                                },
                                child: const Text('Chơi ngay',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Game {
  final String name;
  final String shortDescription;
  final String image;
  final Function onClick;

  Game({
    required this.name,
    required this.shortDescription,
    required this.image,
    required this.onClick,
  });
}
