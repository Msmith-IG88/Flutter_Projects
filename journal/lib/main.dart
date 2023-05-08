import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/components/dark_mode.dart';
import 'app.dart';
import 'database/manager.dart';
import 'components/dark_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await DatabaseManager.initialize();
  await SharedPreferenceTheme.initialize();

  runApp((JournalApp()));
}
