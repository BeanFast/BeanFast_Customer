import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.put(NotificationController());
    return Scaffold(
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
              notificationController.allDone.value = true;
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notificationController.notifications.length,
        itemBuilder: (context, index) {
          final notification = notificationController.notifications[index];
          return SizedBox(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        index.toString(), // title
                        'You clicked on notification $index',
                        snackPosition: SnackPosition.TOP,
                        duration: 0.5.seconds,
                      );
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
                                child: Obx(() {
                                  return Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          notificationController.allDone.value
                                              ? Colors.grey
                                              : Colors.red,
                                      border: const Border.fromBorderSide(
                                        BorderSide(
                                            color: Colors.white, width: 3),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        notification.title,
                                        style: Get.textTheme.titleSmall,
                                      ),
                                      const SizedBox(width: 3),
                                      const Icon(
                                        Icons.circle,
                                        size: 5,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(notification.time,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      const Spacer(),
                                      Icon(notification.trailingIcon, size: 25),
                                    ],
                                  ),
                                  Text(
                                    notification.name,
                                    style: Get.textTheme.labelLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    notification.description,
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
        },
      ),
    );
  }
}

class NotificationController extends GetxController {
  RxBool allDone = false.obs;
  //List notifications
  List<NotificationModel> notifications = [
    NotificationModel(
      icon: Icons.notification_important,
      title: 'đăng nhập và bảo mật',
      name: 'Thông báo quan trong',
      time: '23 giờ trước',
      description: 'Theo quy dịnh nhà nước.\n2\n3\n4',
      trailingIcon: Icons.more_horiz,
    ),
    NotificationModel(
      icon: Icons.notification_important,
      title: 'đăng nhập và bảo mật',
      name: 'Thông báo quan trong',
      time: '23 giờ trước',
      description: 'Theo quy dịnh nhà nước..........',
      trailingIcon: Icons.more_horiz,
    ),
    NotificationModel(
      icon: Icons.notification_important,
      title: 'đăng nhập và bảo mật',
      name: 'Thông báo quan trong',
      time: '23 giờ trước',
      description: 'Theo quy dịnh nhà nước..........',
      trailingIcon: Icons.more_horiz,
    ),
    // Add more notifications as needed
  ];
}

class NotificationModel {
  final IconData icon;
  final String title;
  final String name;
  final String time;
  final String description;
  final IconData trailingIcon;

  NotificationModel({
    required this.icon,
    required this.title,
    required this.name,
    required this.time,
    required this.description,
    required this.trailingIcon,
  });
}
