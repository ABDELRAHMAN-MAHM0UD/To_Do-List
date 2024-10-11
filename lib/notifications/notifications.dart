import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:to_do_list/task_widget/task_widget.dart';

void startChecking({required DateTime targetDateTime, required TaskWidget task}) {
  Timer? timer; // Timer instance

  // Check every minute (60000 milliseconds)
  timer = Timer.periodic(Duration(minutes: 1), (timer) {
    DateTime now = DateTime.now();
    Duration difference = targetDateTime.difference(now);

    // Use a simple counter or task ID modulo 32-bit max to ensure it's valid
    int notificationId1Hour = task.id % 2147483647; // Modulus operation to ensure valid ID
    int notificationId1Day = (task.id + 1) % 2147483647; // Use a different calculation for the day notification

    // Check if the target time is within the next hour
    if (difference.inHours == 0 && difference.inMinutes < 60) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId1Hour, // Use the calculated ID for the one-hour notification
              channelKey: 'channelKey',
              title: "Task not done yet",
              body: "Task: ${task.taskTitle}"));
      timer.cancel(); // Cancel the timer after the action is performed
    }
    // Check if the target time is within the next day
    else if (difference.inDays == 0 && difference.inHours < 24) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId1Day, // Use the calculated ID for the one-day notification
              channelKey: 'channelKey',
              title: "Task Reminder",
              body: "don't forget: ${task.taskTitle}"));
      timer.cancel(); // Cancel the timer after the action is performed
    }
    // If the target time has passed, cancel the timer
    else if (difference.isNegative) {
      timer.cancel();
    }
  });
}
