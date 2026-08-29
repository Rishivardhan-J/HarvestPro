import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SmsGateway {
  Future<void> sendSms(String phoneNumber, String message);
}

abstract class IvrProvider {
  Future<void> initiateCall(String phoneNumber);
}

class MockSmsGateway implements SmsGateway {
  @override
  Future<void> sendSms(String phoneNumber, String message) async {
    debugPrint('MockSmsGateway: Sent SMS to $phoneNumber with message: $message');
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }
}

class MockIvrProvider implements IvrProvider {
  @override
  Future<void> initiateCall(String phoneNumber) async {
    debugPrint('MockIvrProvider: Initiated IVR call to $phoneNumber');
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }
}

final smsGatewayProvider = Provider<SmsGateway>((ref) {
  return MockSmsGateway();
});

final ivrProvider = Provider<IvrProvider>((ref) {
  return MockIvrProvider();
});
