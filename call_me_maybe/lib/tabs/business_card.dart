import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String phoneNumberDisplay = '000-000-0000';
    final String phoneNumberLaunch = 'sms:0000000000';
    final String githubLink = 'github.com/hippo-jedi';
    final String githubLinkLaunch = 'https://github.com/hippo-jedi';
    final String email = 'Smitmic5@oregonstate.edu';

    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.9,
      child: Container(
        child: Column(
          children: [
            profilePicture(context),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Text("Michael Smith",
                  style: TextStyle(fontFamily: 'Arial', fontSize: 25.0)),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Software Engineer",
                style: TextStyle(fontFamily: 'Arial', fontSize: 20.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () {
                  launch(phoneNumberLaunch);
                },
                child: Text(phoneNumberDisplay,
                    style: TextStyle(fontFamily: 'Arial', fontSize: 15.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: paddingRow(context)),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        launch(githubLinkLaunch);
                      },
                      child: Text(githubLink,
                          style:
                              TextStyle(fontFamily: 'Arial', fontSize: 10)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: paddingRow(context)),
                    alignment: Alignment.centerRight,
                    child: Text(email,
                        style: TextStyle(fontFamily: 'Arial', fontSize: 10)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget profilePicture(BuildContext context) {
    double ratio;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      ratio = 5 / 1;
    } else {
      ratio = 5 / 2;
    }

    return AspectRatio(
      aspectRatio: ratio,
      child: Image(image: AssetImage('assets/images/me.png')),
    );
  }

  double paddingRow(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0.2;
    } else {
      return MediaQuery.of(context).size.width * 0.05;
    }
  }
}
