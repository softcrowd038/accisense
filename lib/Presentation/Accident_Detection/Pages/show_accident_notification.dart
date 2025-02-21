import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  void createInitialNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: "accident_channel",
          title: "Accident Detected",
          body: "Is these is an Accident Confirm.",
          color: Colors.orange),
      actionButtons: [
        NotificationActionButton(
          key: "cancel",
          label: "Cancel",
          actionType: ActionType.DismissAction,
        ),
      ],
    );
  }

  void cancelNotification() {
    AwesomeNotifications().cancel(10);
  }
}
