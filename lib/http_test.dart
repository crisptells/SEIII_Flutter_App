import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<User> fetchUser() async {
  final response = await http.get(Uri.parse('http://localhost:3333/Users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonresponse = json.decode(response.body);
    return User.fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

class User {
  final String? email;
  final String? password;
  final String? name;
  final String? firstName;
  final int? cash;

  const User(
      {required this.email,
      required this.password,
      required this.name,
      required this.firstName,
      required this.cash});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        firstName: json['firstName'],
        cash: json['geld']);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                            "Hi ${snapshot.data!.email} your name is ${snapshot.data!.name} and cash ${snapshot.data?.cash} ")
                      ],
                    ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
