import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

/// Entry point for the quick push-to-talk home screen widget.
///
/// The widget is intended to surface a single "favourite" friend so that
/// the user can jump straight into the PTT screen without opening the app.
/// The implementation here is a stub that wires the [home_widget] plugin and
/// logs what would happen when the PTT screen launches.
class QuickPttWidget {
  QuickPttWidget._();

  /// The key that stores the friend identifier in the native widget storage.
  static const String _friendIdKey = 'quick_ptt_friend_id';

  /// Persists the selected friend identifier and notifies the native widgets
  /// about the content change.
  static Future<void> registerFriend(String friendId) async {
    await HomeWidget.saveWidgetData(_friendIdKey, friendId);
    await HomeWidget.updateWidget(
      name: 'QuickPttWidgetProvider',
      androidName: 'QuickPttWidgetProvider',
    );
  }

  /// Loads the friend identifier from the widget storage and performs the
  /// hand-off to the in-app navigation.
  ///
  /// The actual navigation is intentionally left as a stub so the mobile team
  /// can inject the real implementation later.
  static Future<void> openPttScreenForFriend() async {
    final friendId = await HomeWidget.getWidgetData<String>(
      _friendIdKey,
      defaultValue: '',
    );

    if (friendId == null || friendId.isEmpty) {
      debugPrint('QuickPttWidget: No friend configured for quick launch.');
      return;
    }

    // TODO(mvp-widget-1): Replace with actual deep-link or navigator call.
    debugPrint(
      'QuickPttWidget: Launching PTT screen for friend "$friendId".',
    );
  }

  /// Convenience helper used by the platform channels to bridge into Dart.
  static Future<void> handleWidgetLaunch(Uri? data) async {
    final friendId = data?.queryParameters['friendId'];
    if (friendId != null && friendId.isNotEmpty) {
      await registerFriend(friendId);
      await openPttScreenForFriend();
      return;
    }

    await openPttScreenForFriend();
  }
}
