import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'routes/entrys_page.dart';
import 'routes/form.dart';
import 'routes/entry.dart';
import 'components/dark_mode.dart';

class JournalApp extends StatefulWidget {
  @override
  _JournalAppState createState() => _JournalAppState();
}

class _JournalAppState extends State<JournalApp> {
  final prefTheme = SharedPreferenceTheme();
  bool darkMode;

  @override
  void initState() {
    super.initState();
    setState(() {
      darkMode = prefTheme.getDarkMode();
    });
  }

  void updateBrightness() {
    setState(() {
      darkMode = prefTheme.getDarkMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness;

    if (darkMode) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: brightness,
      ),
      routes: {
        JournalEntriesPage.routeName: (context) =>
            JournalEntriesPage(updateBrightness: updateBrightness),
        JournalEntryFormPage.routeName: (context) =>
            JournalEntryFormPage(updateBrightness: updateBrightness),
        JournalEntryPage.routeName: (context) =>
            JournalEntryPage(updateBrightness: updateBrightness),
      },
    );
  }
}
