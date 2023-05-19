import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:meal_aware/screen/home/home_screen.dart';

class NotificationService {
  static Future<void> initialize() async {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/logo',
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
            importance: NotificationImportance.High,
            channelShowBadge: true,
            playSound: true,
            onlyAlertOnce: true,
            criticalAlerts: true,
            locked: false,
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification Created');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedNotification) async {
    debugPrint('Notification Dismissed');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification Displayed');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedNotification) async {
    debugPrint('Action Received');
    debugPrint(receivedNotification.toString());
    if (receivedNotification.buttonKeyPressed == 'ACCEPT') {
      debugPrint('ACCEPT');
    } else if (receivedNotification.buttonKeyPressed == 'REJECT') {
      debugPrint('REJECT');
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String?>?
        payload, // Change the type to Map<String, String?>?
    final ActionType actionType = ActionType.Default,
    final NotificationLayout layout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: layout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              allowWhileIdle: true,
              repeats: true,
            )
          : null,
    );
  }
}
