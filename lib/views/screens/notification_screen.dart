import 'package:beanfast_customer/views/widgets/is_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

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
                controller.markAsRead();
              },
            ),
          ],
        ),
        body: Obx(
          () => controller.notifications.isEmpty
              ? const IsEmptyWidget(title: 'Chưa có thông báo nào')
              : SingleChildScrollView(
                  child: Column(
                    children: controller.notifications.map((notification) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Get.snackbar(
                                //   notification.title!,
                                //   notification.body!,
                                //   snackPosition: SnackPosition.TOP,
                                //   duration: 1.seconds,
                                // );
                              },
                              child: Card(
                                child: Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            const Align(
                                              alignment: Alignment.center,
                                              child: Icon(Iconsax.notification,
                                                  color: Colors
                                                      .black), // Add this line
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      notification.status == 3
                                                          ? Colors.transparent
                                                          : Colors.red,
                                                  // border: const Border.fromBorderSide(
                                                  //   BorderSide(
                                                  //       color: Colors.white,
                                                  //       width: 0),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    notification.title!,
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.circle,
                                                      size: 8,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    SizedBox(
                                                   
                                                      child: Text(
                                                        timeago.format(
                                                            notification
                                                                .sendDate!,
                                                            locale: 'vi'),
                                                        style: Get.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey),
                                                        textAlign:
                                                            TextAlign.right,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                      );
                    }).toList(),
                  ),
                ),
        ),
      ),
    );
  }
}
