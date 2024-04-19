import 'base_model.dart';
import 'package:flutter/material.dart';

class Notification extends BaseModel {
  final IconData icon;
  final String? title;
  final String? body;
  final String? link;
  final DateTime? sendDate;
  final DateTime? readDate;
  // final String description;
  final IconData trailingIcon;

  Notification({
    required this.icon,
    required this.title,
    required this.link,
    required this.sendDate,
    required this.readDate,
    required this.trailingIcon,
    required this.body,
  });
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      icon: Icons.notification_important,
      title: json['title'],
      body: json['body'],
      link: json['link'],
      sendDate: DateTime.parse(json['sendDate']),
      readDate:
          json['readDate'] == null ? null : DateTime.parse(json['readDate']),
      trailingIcon: Icons.more_horiz,
    );
  }
}
