import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../permissions/jit_permission_flow.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    try {
      // FCM Token (Mocked since Firebase is not fully configured with google-services.json)
      // This might throw if Firebase isn't initialized, we catch it.
      try {
        final token = await _messaging.getToken();
        debugPrint('FCM Token: $token');
      } catch (e) {
        debugPrint('FCM getToken skipped (Firebase not configured): $e');
      }

      // Local Notifications Setup
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(android: androidSettings);
      
      await _localNotifications.initialize(settings: initSettings);
      _initialized = true;
    } catch (e) {
      debugPrint('Failed to initialize NotificationService: $e');
    }
  }

  Future<PermissionStatus> requestPermission(BuildContext context) async {
    return JitPermissionFlow.requestWithRationale(
      context,
      Permission.notification,
      rationaleMessage: 'HarvestPro uses notifications to send you daily weather updates and crop advisories.',
      icon: Icons.notifications,
    );
  }

  Future<void> scheduleEarlyMorningAdvisory(TimeOfDay time, String title, String body) async {
    if (!_initialized) {
      await init();
    }

    final status = await Permission.notification.status;
    if (!status.isGranted) {
      return;
    }

    // In a real app we would use timezone for scheduling (zonedSchedule).
    // Here we'll simulate it with a simple delay or show it immediately for testing if needed.
    // For the sake of the mock, we just show a notification after a short delay 
    // since `zonedSchedule` requires `timezone` package initialization.
    
    const androidDetails = AndroidNotificationDetails(
      'advisory_channel',
      'Daily Advisories',
      channelDescription: 'Early morning crop and weather advisories',
      importance: Importance.max,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    // Using show for the stub instead of scheduling to avoid timezone init complexity,
    // but the API surface is ready.
    await _localNotifications.show(
      id: Random().nextInt(10000),
      title: title,
      body: body,
      notificationDetails: details,
    );
    debugPrint('Scheduled (Shown) advisory notification: $title at $time');
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});
