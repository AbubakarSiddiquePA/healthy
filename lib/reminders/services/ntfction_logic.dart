import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy/reminders/rmndr_home.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationLogic {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          "Schedule Reminder", "Do not forget to drink water",
          importance: Importance.max, priority: Priority.max),
    );
  }

  static Future init(BuildContext context, String uid) async {
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings("res_app_icon");
    final settings = InitializationSettings(android: android);
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payLoad) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReminderPage(),
          ),
        );
        onNotifications.add(payLoad as String);
      },
    );
  }

  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
    required DateTime dateTime,
  }) async {
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(Duration(days: 1));
    }
    _notifications.zonedSchedule(id, title, body,
        tz.TZDateTime.from(dateTime, tz.local), await NotificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
