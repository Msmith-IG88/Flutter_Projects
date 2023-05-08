import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'package:wasteagram/screens/info_screen.dart';
import 'package:wasteagram/screens/posts_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;

class WasteagramApp extends StatelessWidget {
  StreamingSharedPreferences preferences;
  WasteagramApp(this.preferences);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.light(),
      routes: {
        DetailScreen.routeName: (context) => DetailScreen(),
        ListScreen.routeName: (context) => ListScreen(preferences),
        NewPostFormScreen.routeName: (context) => NewPostFormScreen(),
      },
    );
  }
  static Future<void> reportError(
      dynamic error, dynamic stackTrace, String sentryURL) async {
    if (Foundation.kDebugMode) {
      print(stackTrace);
      return;
    }
  }
}
