import 'base_model.dart';
import 'package:flutter/material.dart';

class NotificationModel extends BaseModel {
  final IconData icon;
  final String? title;
  final String? body;
  final String? link;
  final DateTime? sendDate;
  final DateTime? readDate;
  // final String description;
  final IconData trailingIcon;

  NotificationModel({
    required this.icon,
    required this.title,
    required this.link,
    required this.sendDate,
    required this.readDate,
    required this.trailingIcon,
    required this.body,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      icon: Icons.notification_important,
      title: json['title'],
      body: json['body'],
      link: json['link'],
      sendDate: DateTime.parse(json['sendDate']),
      readDate: DateTime.parse(json['readDate']),
      trailingIcon: Icons.more_horiz,
    );
  }
}
