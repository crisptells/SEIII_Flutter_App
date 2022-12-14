import 'package:flutter/material.dart';
import 'package:flutter_test_app/learn_flutter_page.dart';

final makeListTile = ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
  trailing:
      const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
);

final makeCard = Card(
  elevation: 8.0,
  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  child: Container(
    decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
    child: makeListTile,
  ),
);

class NachhilfePage extends StatelessWidget {
  const NachhilfePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, index) {
        return makeCard;
      },
    );
  }
}

