import 'dart:async';

/// Handles registration of the device for Firebase Cloud Messaging and
/// reacts to background push notifications.
class PushHandler {
  const PushHandler();

  Future<void> initialise() async {
    // TODO: Request messaging permissions and obtain the FCM token.
    await Future<void>.delayed(Duration.zero);
  }

  Future<void> onTokenRefreshed(String token) async {
    // TODO: Persist the refreshed FCM token with the backend service.
    await Future<void>.delayed(Duration.zero);
  }

  Future<void> onMessageReceived(Map<String, dynamic> data) async {
    // TODO: Wake the push-to-talk service when a data message arrives.
    await Future<void>.delayed(Duration.zero);
  }
}
