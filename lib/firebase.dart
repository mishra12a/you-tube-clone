import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String?> getFcmToken(Permission permissionHandler) async {
  try {
    // 1. Request notification permissions if necessary (recommended):
    NotificationSettings settings = await FirebaseMessaging.instance.getNotificationSettings();
    if (!(await settings.authorizationStatus == AuthorizationStatus.authorized)) {
      // Use platform-specific permission handler if provided:
      if (permissionHandler != null) {
        PermissionStatus status = await Permission.notification.request();
        if (status != PermissionStatus.granted) {
          print("Notification permissions denied.");
          return null;
        }
      } else {
        // Handle permission request without a platform-specific handler:
        NotificationSettings permissions = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          sound: true,
        );
        if (!(await permissions.authorizationStatus == AuthorizationStatus.authorized)) {
          print("Notification permissions denied.");
          return null;
        }
      }
    }
    
    // 2. Get the FCM token:
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print("FCM Token: $token");
      FirebaseMessaging.onBackgroundMessage(noti_handdle);
      return token;
    } else {
      print("Failed to get FCM token. Retrying in 5 seconds...");
      await Future.delayed(const Duration(seconds: 5));
      return await getFcmToken(permissionHandler); // Retry
    }
  } on Exception catch (e) {
    print("Error getting FCM token: $e");
    // Handle errors more gracefully if needed
    return null;
  }
}

Future<void> noti_handdle(RemoteMessage message) async{
  print('notific is red');
  print("Title ${message.notification?.title}");
  print("Title ${message.notification?.body}");
  print("Title ${message.data}");
}
