import 'dart:convert';
import 'dart:io';
import 'package:disstrikt/app/export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_init;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  // Channel IDs
  static const String _channelId = 'badminton_notification_channel';
  static const String _channelName = 'Badminton Notifications';
  static const String _channelDesc = 'Notifications for Badminton app';

  // Initialize notification service
  Future<void> init() async {
    // Initialize timezone
    tz_init.initializeTimeZones();

    // Request notification permissions for iOS and Android 13+
    await _requestPermissions();

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        debugPrint('Notification clicked: ${notificationResponse.payload}');
        if (notificationResponse.payload != null) {
          try {
            final Map<String, dynamic> data =
                json.decode(notificationResponse.payload!);
            _handleNotificationData(data);
          } catch (e) {
            debugPrint('Error parsing notification payload: $e');
            selectNotificationSubject.add(notificationResponse.payload);
          }
        }
      },
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              _channelId,
              _channelName,
              description: _channelDesc,
              importance: Importance.high,
              enableVibration: true,
              enableLights: true,
            ),
          );
    }

    // Configure Firebase Messaging
    await _configureFirebaseMessaging();
  }

  // Request notification permissions
  Future<void> _requestPermissions() async {
    // For iOS
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    // For Android
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      // Request permission for Android 13+
      await androidImplementation?.requestNotificationsPermission();
    }

    // Request FCM permission
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
  }

  // Configure Firebase Messaging
  Future<void> _configureFirebaseMessaging() async {
    // Get FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $token');

    // For iOS: get and log APNs token (helps diagnose push issues)
    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      debugPrint('APNs Token: $apnsToken');
      // Ensure notifications show while app is in foreground
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // Subscribe to topics if needed
    await FirebaseMessaging.instance.subscribeToTopic('all_users');

    // Handle token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token refreshed: $newToken');
      // TODO: Send the new token to your server
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
        _showNotification(message);
      } else if (message.data.isNotEmpty) {
        // If there's no notification but there is data, create a notification from the data
        String title = message.data['title'] ?? 'New Notification';
        String body = message.data['body'] ?? 'You have a new notification';

        showNotification(
          id: message.hashCode,
          title: title,
          body: body,
          payload: json.encode(message.data),
        );
      }
    });

    // Check if app was opened from a notification when it was terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('App opened from terminated state by notification');
      _handleNotificationTap(initialMessage);
    }

    // Handle notification tap when app is in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      _handleNotificationTap(message);
    });
  }

  // Show notification
  Future<void> _showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    // Check if the notification is for a chat message and if the user is on the chat screen
    if (Get.currentRoute == '/chat_screen') {
      final notificationChatId = message.data['referenceId'];

      debugPrint(
          'Skipping notification: User is already on the chat screen for chatId $notificationChatId');
      return; // Skip showing the notification
    }

    // If notification is null, create one from data
    if (notification == null) {
      String title = message.data['title'] ?? 'New Notification';
      String body = message.data['body'] ?? 'You have a new notification';

      await showNotification(
        id: message.hashCode,
        title: title,
        body: body,
        payload: json.encode(message.data),
      );
      return;
    }

    // For Android
    if (Platform.isAndroid && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDesc,
            icon: android.smallIcon ?? '@mipmap/ic_launcher',
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.green,
            playSound: true,
            enableVibration: true,
            enableLights: true,
          ),
        ),
        payload: json.encode(message.data),
      );
    }

    // For iOS
    else if (Platform.isIOS && apple != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: json.encode(message.data),
      );
    }
  }

  // Show a local notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: const AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.green,
          playSound: true,
          enableVibration: true,
          enableLights: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  // Schedule a notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: const AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          enableLights: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  // Cancel a notification
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    // Extract data from notification
    Map<String, dynamic> data = message.data;
    _handleNotificationData(data);
  }

  // Handle notification data
  void _handleNotificationData(Map<String, dynamic> data) {
    // Handle different notification types
    String? notificationType = data['type'];
    String? targetId = data['referenceId'];

    if (notificationType == null) {
      // Default to notification screen if type is not specified
      Get.toNamed(AppRoutes.NotificationScreen);
      return;
    }

    switch (notificationType) {
      default:
        Get.toNamed(AppRoutes.NotificationScreen);
        break;
    }
  }

  // Dispose resources
  void dispose() {
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
  }

  // Add this method to check notification permissions
  Future<bool> checkNotificationPermissions() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    debugPrint(
        'Notification permission status: ${settings.authorizationStatus}');

    // Also check local notification permissions
    final permissionStatus = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.checkPermissions();
    debugPrint('Local notification permission status: $permissionStatus');

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}

// Model for received notifications
class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
