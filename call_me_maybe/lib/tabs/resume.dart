import 'package:flutter/material.dart';
import '../classes/row.dart';

class Resume extends StatelessWidget {
  final List<ResumeRow> resumes = [
    ResumeRow(
      position: "Michael Smith",
      dateRange: "",
      company: "",
      location: "",
      details: "smitmic5@oregonstate.edu",
    ),
    ResumeRow(
        position: "Software Developer Internship",
        dateRange: "2020-Present",
        company: "CollegeNet",
        location: "Portland, OR",
        details:
            "I am currently a front-end web developer for the myCoalition website owned by CollegeNet. I attend daily meetings, fix bugs, push updates, and improve the user experience.",
    ),
    ResumeRow(
      position: "Pizza Delivery Driver",
      dateRange: "2017-2019",
      company: "Pizza Hut",
      location: "Portland, OR",
      details:
          "I worked as a dishwasher, cook, cashier, and delivery driver for Pizza hut. This included improving customer service, training new employees, and making deliveries on time.",
    ),
    ResumeRow(
      position: "Filler",
      dateRange: "N/A",
      company: "N/A",
      location: "N/A",
      details:
          "N/A",
    ),
    ResumeRow(
      position: "Filler",
      dateRange: "N/A",
      company: "N/A",
      location: "N/A",
      details:
          "N/A",
    ),
    ResumeRow(
      position: "Filler",
      dateRange: "N/A",
      company: "N/A",
      location: "N/A",
      details:
          "N/A",
    ),
    ResumeRow(
      position: "Filler",
      dateRange: "N/A",
      company: "N/A",
      location: "N/A",
      details:
          "N/A",
    ),
    ResumeRow(
      position: "Filler",
      dateRange: "N/A",
      company: "N/A",
      location: "N/A",
      details:
          "N/A",
    ),
    ResumeRow(
      position: "Filler",
      dateRange: "N/A",
      company: "N/A",
      location: "N/A",
      details:
          "N/A",
    ),
    ResumeRow(
      position: "Filler",
      dateRange: "N/A",
      company: "N/A",
      location: "N/A",
      details:
          "N/A",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> resumesList = resumeRowList(resumes);

    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: resumesList,
        ),
      ),
    );
  }

  List<Widget> resumeRowList(List<ResumeRow> resumes) {
    List<Widget> resumesList = [];
    resumes.forEach((resume) {
      resumesList.add(resumeRowWidget(resume));
    });

    return resumesList;
  }

  Widget resumeRowWidget(ResumeRow resume) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          Text(resume.position,
              style: TextStyle(fontFamily: 'Arial', fontSize: 20.0)),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(resume.company,
                      style: TextStyle(
                          fontFamily: 'Arial', fontSize: 12.0)),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(resume.dateRange,
                      style: TextStyle(
                          fontFamily: 'Arial', fontSize: 12.0)),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(resume.location,
                      style: TextStyle(
                          fontFamily: 'Arial', fontSize: 12.0)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 7),
            child: Text(resume.details),
          ),
        ],
      ),
    );
  }
}
