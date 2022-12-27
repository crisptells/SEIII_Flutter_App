import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test_app/datattypes/datatypes.dart';
import 'package:flutter_test_app/learn_flutter_page.dart';

final makeListTile = ListTile(
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: const EdgeInsets.only(right: 12.0),
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
      child: const Icon(Icons.school, color: Colors.white),
    ),
    title: const Text(
      "Kurs für Nachhilfe",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

    subtitle: Row(
      children: const <Widget>[
        Icon(Icons.linear_scale, color: Colors.yellowAccent),
        Text(" Schwierigkeit: Normal", style: TextStyle(color: Colors.white))
      ],
    ),
    trailing: const Icon(Icons.keyboard_arrow_right,
        color: Colors.white, size: 30.0));

final makeCard = Card(
  elevation: 8.0,
  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  child: Container(
    decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
    child: makeListTile,
  ),
);

class NachhilfePage extends StatelessWidget {
  //const NachhilfePage({super.key});
  //get all Tutorings in a List
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
        appBar: AppBar(
          title: const Text("ListView with Tutorings"),
          centerTitle: true,
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
        )),
      );

  Widget buildTutorings(List<Tutoring> tutorings) => ListView.builder(
        itemCount: tutorings.length,
        itemBuilder: (context, index) {
          final tutoring = tutorings[index];

          return Card(
            child: ListTile(
              title: Text(tutoring.subject),
              subtitle: Text(tutoring.tutor),
            ),
          );
        },
      );
}
