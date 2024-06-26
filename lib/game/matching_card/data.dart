import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

List<String> imageSource() {
  return [
    //1
    'assets/game_assets/matching_card/image_1.png',
    'assets/game_assets/matching_card/image_2.png',
    'assets/game_assets/matching_card/image_3.png',
    'assets/game_assets/matching_card/image_4.png',
    'assets/game_assets/matching_card/image_5.png',
    'assets/game_assets/matching_card/image_6.png',
    'assets/game_assets/matching_card/image_7.png',
    'assets/game_assets/matching_card/image_8.png',
    //2
    'assets/game_assets/matching_card/image_1.png',
    'assets/game_assets/matching_card/image_2.png',
    'assets/game_assets/matching_card/image_3.png',
    'assets/game_assets/matching_card/image_4.png',
    'assets/game_assets/matching_card/image_5.png',
    'assets/game_assets/matching_card/image_6.png',
    'assets/game_assets/matching_card/image_7.png',
    'assets/game_assets/matching_card/image_8.png',
  ];
}

List createShuffledListFromImageSource() {
  List shuffledImages = [];
  List sourceArray = imageSource();
  for (var element in sourceArray) {
    shuffledImages.add(element);
  }
  shuffledImages.shuffle();
  return shuffledImages;
}

List<bool> getInitialItemStateList() {
  List<bool> initialItem = <bool>[];
  for (int i = 0; i < 16; i++) {
    initialItem.add(true);
  }
  return initialItem;
}

List<GlobalKey<FlipCardState>> createFlipCardStateKeysList() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 16; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
