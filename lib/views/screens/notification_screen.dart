import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/controllers/notification_controller.dart';
import '/views/screens/loading_screen.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    return LoadingScreen(
      future: () async {
        await controller.fetchData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thông báo',
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Iconsax.tick_square,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                controller.allDone.value = true;
              },
            ),
          ],
        ),
        body: Obx(
          () => Column(
            children: controller.notifications.map((notification) {
              return SizedBox(
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.snackbar(
                          //   index.toString(), // title
                          //   'You clicked on notification $index',
                          //   snackPosition: SnackPosition.TOP,
                          //   duration: 0.5.seconds,
                          // );
                        },
                        child: Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://via.placeholder.com/150'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: notification.readDate != null
                                            ? Colors.grey
                                            : Colors.red,
                                        border: const Border.fromBorderSide(
                                          BorderSide(
                                              color: Colors.white, width: 3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            notification.title!,
                                            style: Get.textTheme.titleSmall,
                                          ),
                                          const SizedBox(width: 3),
                                          const Icon(
                                            Icons.circle,
                                            size: 5,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(notification.sendDate.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey)),
                                          const Spacer(),
                                          Icon(notification.trailingIcon,
                                              size: 25),
                                        ],
                                      ),
                                      Text(
                                        notification.body!,
                                        style: Get.textTheme.bodySmall,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

