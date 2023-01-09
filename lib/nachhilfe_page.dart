import 'dart:convert';
import 'package:flutter_test_app/enter_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test_app/datattypes/datatypes.dart';

class NachhilfePage extends StatelessWidget {
  Future<List<Tutoring>> tutoringsFuture = getTutorings();

  TextEditingController kursController = TextEditingController();
  TextEditingController dozentController = TextEditingController();

  NachhilfePage({super.key});
  static Future<List<Tutoring>> getTutorings() async {
    const url = "http://127.0.0.1:3333/Tutorings";
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    return body.map<Tutoring>(Tutoring.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Kurse",
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).iconTheme.color,
        ),
        body: Center(
          child: FutureBuilder<List<Tutoring>>(
            future: tutoringsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Ahh error! ${snapshot.hasError}');
              } else if (snapshot.hasData) {
                final tutorings = snapshot.data!;
                return buildTutorings(tutorings);
              } else {
                return const Text("no Tutorings data");
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _dialogBuilder(context),
          backgroundColor: Theme.of(context).backgroundColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      );

  Widget buildTutorings(List<Tutoring> tutorings) => ListView.builder(
        itemCount: tutorings.length,
        itemBuilder: (context, index) {
          final tutoring = tutorings[index];

          return Card(
            child: ListTile(
              tileColor: Theme.of(context).backgroundColor,
              title: Text(
                tutoring.subject,
                style: TextStyle(color: Theme.of(context).iconTheme.color),
              ),
              subtitle: Text(
                tutoring.tutor,
                style: TextStyle(color: Theme.of(context).iconTheme.color),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EnterPage(
                          subject: tutoring.subject,
                          tutor: tutoring.tutor,
                          tutoring_id: tutoring.tutoring_id,
                        )));
              },
              leading: Icon(
                Icons.school,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          );
        },
      );

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Kurs hinzufügen',
            style: TextStyle(
                color: Theme.of(context).iconTheme.color, fontSize: 24),
          ),
          content: SizedBox(
            height: 230,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Kurs:',
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Theme.of(context).iconTheme.color),
                  cursorColor: Theme.of(context).iconTheme.color,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color!)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Beschreibung:',
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Theme.of(context).iconTheme.color),
                  cursorColor: Theme.of(context).iconTheme.color,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color!)),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              child: Text(
                'Zurück',
                style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  backgroundColor: Theme.of(context).backgroundColor),
              child: Text(
                'Hinzufügen',
                style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
