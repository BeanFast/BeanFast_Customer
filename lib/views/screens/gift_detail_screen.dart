import 'package:beanfast_customer/models/gift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GiftDetailScreen extends StatelessWidget {
  final Gift gift;
  const GiftDetailScreen({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.8,
                child: Image.network(gift.imagePath!, fit: BoxFit.cover),
              ),
              Stack(
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gift.name!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
                                child: Row(
                                  children: [
                                    Text(
                                      gift.points!.toString(),
                                      style: Get.textTheme.bodyLarge!
                                          .copyWith(color: Colors.red),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.card_giftcard,
                                        color: Colors.orange)
                                  ],
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
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
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mô tả', style: TextStyle(fontSize: 16)),
                      Text(gift.description!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
