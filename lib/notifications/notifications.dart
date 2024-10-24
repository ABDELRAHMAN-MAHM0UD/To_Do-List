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
// Notify one hour before the task's due time
    if (difference.inMinutes <= 60 && difference.inMinutes > 0) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId1Hour, // Use the calculated ID for the one-hour notification
              channelKey: 'channelKey',
              title: "Task Reminder",
              body: "Task: ${task.taskTitle}"));
      timer.cancel(); // Cancel the timer after the action is performed
    }
// Notify one day before the task's due time
    else if (difference.inHours <= 24 && difference.inHours > 1) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId1Day, // Use the calculated ID for the one-day notification
              channelKey: 'channelKey',
              title: "Task Reminder",
              body: "Don't forget: ${task.taskTitle}"));
      timer.cancel(); // Cancel the timer after the action is performed
    }

    // If the target time has passed, cancel the timer
    else if (difference.isNegative) {
      timer.cancel();
    }
  });
}
