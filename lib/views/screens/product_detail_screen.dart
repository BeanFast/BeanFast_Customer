import 'package:beanfast_customer/models/food.dart';
import 'package:beanfast_customer/utils/formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '/controllers/cart_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final Food food;
  const ProductDetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(food.imagePath.toString()),
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                ),
                Stack(
                  children: [
                    Card(
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name.toString(),
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Formater.formatMoney(food.price.toString()),
                              style: Get.textTheme.bodyLarge!.copyWith(
                                  color: const Color.fromRGBO(240, 103, 24, 1)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   top: 0,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(4),
                    //     ),
                    //     child: Container(
                    //       padding: const EdgeInsets.all(4),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(4),
                    //       ),
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 6, vertical: 3),
                    //         decoration: const BoxDecoration(
                    //           color: Colors.red,
                    //           borderRadius: BorderRadius.only(
                    //             bottomLeft: Radius.circular(12),
                    //             topRight: Radius.circular(12),
                    //           ),
                    //         ),
                    //         child: const Text(
                    //           '40%',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 12,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mô tả', style: Get.textTheme.titleMedium),
                        const SizedBox(height: 5),
                        Text(food.description.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
