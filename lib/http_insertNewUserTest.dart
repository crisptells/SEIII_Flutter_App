import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<User> createUser(String email, String password, String name,
    String firstName, int cash) async {
  final response = await http.post(
    Uri.parse('http://localhost:3333/AddUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'firstname': firstName,
      'cash': cash
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
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

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() {
    return _CreateUserState();
  }
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController cashController = TextEditingController();
  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
          automaticallyImplyLeading:
              false, // automatischer Back Button aus der App Bar weg (bei false)
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 223, 233, 224),
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureUser == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: 'Enter email'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(hintText: 'Enter password'),
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Enter name'),
        ),
        TextField(
          controller: firstNameController,
          decoration: const InputDecoration(hintText: 'Enter first name'),
        ),
        TextField(
          controller: cashController,
          decoration: const InputDecoration(hintText: 'Enter Cash'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureUser = createUser(
                  emailController.text,
                  passwordController.text,
                  nameController.text,
                  firstNameController.text,
                  int.parse(cashController.text));
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
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

        return const CircularProgressIndicator();
      },
    );
  }
}
