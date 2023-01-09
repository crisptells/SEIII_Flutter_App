import 'dart:convert';
import 'package:flutter_test_app/enter_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test_app/datattypes/datatypes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NachhilfePage extends StatefulWidget {
  const NachhilfePage({super.key});
  @override
  State<NachhilfePage> createState() => _NachhilfePageState();
}

class _NachhilfePageState extends State<NachhilfePage> {
  Future<List<Tutoring>> tutoringsFuture = getTutorings();

  TextEditingController kursController = TextEditingController();
  TextEditingController beschreibungController = TextEditingController();

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
                          description: tutoring.description,
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
                SizedBox(
                  width: 500,
                  child: TextField(
                    controller: kursController,
                    decoration: InputDecoration(
                        labelText: 'Fach',
                        labelStyle: TextStyle(
                            color: Theme.of(context).iconTheme.color)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: beschreibungController,
                  decoration: InputDecoration(
                      labelText: 'Beschreibung',
                      labelStyle:
                          TextStyle(color: Theme.of(context).iconTheme.color)),
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
                createTutoring();
                showActionSnackbar(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void createTutoring() async {
    getUser().then((value) async {
      http.Response response =
          await http.post(Uri.parse('http://127.0.0.1:3333/AddTutoring'),
              body: jsonEncode(<String, String>{
                "tutor": value.name,
                "subject": kursController.text.toString(),
                "description": beschreibungController.text.toString()
              }));
      if (response.statusCode == 200) {
        print("yay");
      }
    });
  }

  Future<User>? userFuture = getUser();
  //Method to retrieve user data
  static Future<User> getUser() async {
    //Use store manager to read logged in user
    var prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('loggedInUser')!;

    //Send Get User request to backend with email of logged in user
    final response = await http.post(Uri.parse('http://127.0.0.1:3333/User'),
        body: jsonEncode(<String, String>{"email": userEmail}));
    var body = json.decode(response.body);
    return User.fromJson(body);
  }

  void showActionSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: const [
          Text(
            "Kurs erfolgreich erstellt! ",
            style: TextStyle(fontSize: 16),
          ),
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        ],
      ),
      action: SnackBarAction(
        label: " ",
        onPressed: () {
          // print("SnackBar Action");
        },
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
