import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'header.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  runApp(MyApp(
    title: "Call Me Maybe",
  ));
}
