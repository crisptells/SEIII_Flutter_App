import 'dart:convert';
import 'package:flutter_test_app/enter_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test_app/datattypes/datatypes.dart';


class NachhilfePage extends StatelessWidget {
  Future<List<Tutoring>> tutoringsFuture = getTutorings();

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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EnterPage(subject: tutoring.subject, tutor: tutoring.tutor)));
              },
              leading: Icon(
                Icons.school,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          );
        },
      );
}
