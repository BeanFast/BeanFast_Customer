import 'package:beanfast_customer/models/food.dart';
import 'package:beanfast_customer/utils/formater.dart';
import 'package:flutter/material.dart';
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Image.network(food.imagePath.toString(),
                      fit: BoxFit.cover),
                ),
                Stack(
                  children: [
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name.toString(),
                              style: Get.textTheme.bodyLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                // const Text(
                                //   '150.000',
                                //   style: TextStyle(
                                //       decoration: TextDecoration.lineThrough,
                                //       fontSize: 16,
                                //       color: Colors.grey),
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
                                // const SizedBox(width: 5),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          216) /
                                      2,
                                  child: Text(
                                    Formater.formatMoney(food.price.toString()),
                                    style: Get.textTheme.bodyLarge!
                                        .copyWith(color: Colors.red),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const Spacer(),
                                // Obx(
                                //   () {
                                //     return cartController.quantity.value == 0
                                //         ? IconButton(
                                //             icon: const Icon(Icons.add),
                                //             onPressed: cartController.increase,
                                //           )
                                //         : Row(
                                //             children: <Widget>[
                                //               IconButton(
                                //                 icon: const Icon(Icons.remove),
                                //                 onPressed:
                                //                     cartController.decrease,
                                //               ),
                                //               Container(
                                //                   alignment: Alignment.center,
                                //                   width: 20,
                                //                   child: Text(
                                //                       '${cartController.quantity.value}')),
                                //               IconButton(
                                //                 icon: const Icon(Icons.add),
                                //                 onPressed:
                                //                     cartController.increase,
                                //               ),
                                //             ],
                                //           );
                                //   },
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
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
                              '40%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const Divider(),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mô tả', style: Get.textTheme.titleMedium),
                        Text(food.description.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
