import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/controllers/game_menu_controller.dart';
import '/utils/formater.dart';
import '/game/matching_card/start_game_screen.dart';
import '/game/pac_man/pacman_homepage.dart';
import '/game/tetris/board.dart';
import '/utils/constants.dart';
import '/views/widgets/image_default.dart';
import '/views/screens/loading_screen.dart';

class GameMenuScreen extends GetView<GameMenuController> {
  const GameMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(GameMenuController());

    List<Game> games = [
      Game(
        name: 'Matching Game - Trò chơi trí nhớ',
        shortDescription:
            'trò chơi trí nhớ đơn giản nhưng đầy thú vị, phù hợp với mọi lứa tuổi. Trò chơi này giúp rèn luyện khả năng ghi nhớ, tập trung và phân biệt hình ảnh.',
        image:
            'https://img.kwcdn.com/product/open/2023-12-13/1702469460222-0d8533f2967848f485a9eb3c287c883e-goods.jpeg?imageMogr2/auto-orient%7CimageView2/2/w/800/q/70/format/webp',
        onClick: () {
          Get.to(() => const StartGameScreen());
        },
      ),
      Game(
        name: 'Pac-Man',
        shortDescription:
            'Pac-Man là một trò chơi đơn giản nhưng đầy thử thách, phù hợp với mọi lứa tuổi. Trò chơi giúp rèn luyện khả năng phối hợp tay mắt, phản xạ nhanh nhạy và khả năng tập trung.',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Pac_Man.svg/800px-Pac_Man.svg.png',
        onClick: () {
          Get.to(() => const PacmanGame());
        },
      ),
      Game(
        name: 'Tetris - Xếp hình',
        shortDescription:
            'Tetris là một trò chơi xếp hình kinh điển, nơi bạn điều khiển các khối hình vuông rơi xuống, gọi là tetrominoes, để sắp xếp chúng thành các hàng ngang hoàn chỉnh. ',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGs3JwFghtgDy5oy9HPWl794T3CGBHKvaELV9xsi2KJg&s',
        onClick: () {
          Get.to(() => const GameBoard());
        },
      ),
    ];
    //UI
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              children: [
                const Text('Lượt chơi: '),
                Obx(
                  () => Text(
                    controller.playTimes.toString(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => Text(
                    Formater.formatPoint(
                        currentUser.value!.points.toString()),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Iconsax.gift,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      body: LoadingScreen(
        future: controller.fetchData,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              games.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 0, top: 0),
                child: Card(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 110,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                child: CustomNetworkImage(
                                  games[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 5,
                                          right: 10,
                                          bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              games[index].name,
                                              style: Get.textTheme.bodyLarge,
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
                                                style: Get
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                  color: Colors.black54,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            const EdgeInsets.all(5)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (controller.playTimes >= 1) {
                                          games[index].onClick();
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Thông báo'),
                                                content: const Text(
                                                    'Bạn đã hết lượt chơi cho hôm nay!.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Text('Chơi ngay',
                                          style: Get.textTheme.bodyLarge),
                                    ),
                                  ),
                                ],
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
                          child: Text(
                            'NEW',
                            style: Get.textTheme.bodySmall!
                                .copyWith(color: Colors.white),
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
