import 'package:flutter/material.dart';
import '../components/journal_theme.dart';
import '../database/manager.dart';
import '../components/entry_model.dart';

class JournalEntryFormPage extends StatelessWidget {
  static const routeName = '/form';
  final void Function() updateBrightness;

  JournalEntryFormPage({this.updateBrightness});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Entry"),
      ),
      body: JournalEntryForm(),
      endDrawer: JournalDrawer(updateBrightness: updateBrightness),
    );
  }
}

class JournalEntryForm extends StatefulWidget {
  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  String title;
  String body;
  int rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          children: <Widget>[
            Container(
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a title';
                  }
                  print(value);
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  body = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a body';
                  }
                  print(value);
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: DropdownButtonFormField<int>(
                isExpanded: false,
                value: rating,
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                    .map(
                      (val) => DropdownMenuItem(
                        child: Text(val.toString()),
                        value: val,
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  rating = value;
                },
                onSaved: (value) {
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a rating';
                  }

                  print(value);
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();

                      final entry = JournalEntry(
                          title: title,
                          body: body,
                          rating: rating,
                          date: DateTime.now());

                      final dbm = DatabaseManager.getInstance();

                      dbm.saveJournalEntry(entry);

                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text('Save'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
