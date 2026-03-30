import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(settings: settings);
    _initialized = true;
  }

  Future<void> scheduleBakeReminder(DateTime bakeTime) async {
    await _plugin.zonedSchedule(
      id: 0,
      title: 'Time to bake! 🍕',
      body: 'Your dough is ready — fire up the oven!',
      scheduledDate: tz.TZDateTime.from(bakeTime, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'bake_reminder',
          'Bake Reminders',
          channelDescription: 'Reminder when your dough is ready to bake',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelBakeReminder() async {
    await _plugin.cancel(id: 0);
  }
}
