import 'package:flutter/material.dart';

import 'tabs/business_card.dart';
import 'tabs/resume.dart';
import 'tabs/predictor.dart';

class MainTabs extends StatelessWidget {
  final String title;
  const MainTabs({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Color.fromARGB(249, 237, 231, 164),
        appBar: AppBar(
            title: Center(child: Text(title, textAlign: TextAlign.center)),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.account_box_outlined)),
                Tab(icon: Icon(Icons.notes_rounded)),
                Tab(icon: Icon(Icons.help_center_outlined)),
              ],
            )),
        body: TabBarView(
          children: [
            BusinessCard(),
            Resume(),
            Predictor(),
          ],
        ),
      ),
    );
  }
}
