import 'package:flutter/material.dart';
import 'package:journal/routes/entry.dart';
import '../components/journal_theme.dart';
import 'form.dart';
import 'entry.dart';
import '../components/entry_model.dart';
import '../database/manager.dart';

class JournalEntriesPage extends StatelessWidget {
  static const routeName = '/';

  final void Function() updateBrightness;

  JournalEntriesPage({this.updateBrightness});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Journal Entries"),
      ),
      body: JournalEntriesWidget(),
      endDrawer: JournalDrawer(
        updateBrightness: updateBrightness,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(JournalEntryFormPage.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class JournalEntriesWidget extends StatefulWidget {
  @override
  _JournalEntriesWidgetState createState() => _JournalEntriesWidgetState();
}

class _JournalEntriesWidgetState extends State<JournalEntriesWidget> {
  Journal journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final dbm = DatabaseManager.getInstance();

    List<JournalEntry> journalEntries = await dbm.getJournalEntries();
    setState(() {
      journal = Journal(entries: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    loadJournal();

    if (journal == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (journal.isEmpty()) {
      return Center(
        child: Icon(
          Icons.book,
          size: 100,
          semanticLabel: 'Journal',
        ),
      );
    }

    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < 800
              ? VerticalLayout(journal: journal)
              : HorizontalLayout(journal: journal);
        },
      ),
    );
  }
}

class VerticalLayout extends StatelessWidget {
  final Journal journal;

  VerticalLayout({this.journal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: journal.entries.length,
        itemBuilder: (context, idx) {
          return ListTile(
            title: Text(journal.entries[idx].title),
            subtitle: Text(journal.entries[idx].getDateString()),
            onTap: () => Navigator.of(context).pushNamed(
                JournalEntryPage.routeName,
                arguments: journal.entries[idx]),
          );
        },
      ),
    );
  }
}

class HorizontalLayout extends StatelessWidget {
  final Journal journal;

  HorizontalLayout({this.journal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: journal.entries.length,
        itemBuilder: (context, idx) {
          return Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .60,
                child: ListTile(
                  title: Text(journal.entries[idx].title,
                      style: TextStyle(fontSize: 20)),
                  subtitle: Text(journal.entries[idx].getDateString(),
                      style: TextStyle(fontSize: 15)),
                  onTap: () => Navigator.of(context).pushNamed(
                      JournalEntryPage.routeName,
                      arguments: journal.entries[idx]),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      journal.entries[idx].title,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Text(
                      journal.entries[idx].body,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rating: ${journal.entries[idx].rating}',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
