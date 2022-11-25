import 'package:flutter/material.dart';
import 'package:flutter_test_app/learn_flutter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 57, 55, 55),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const LearnFlutterPage();
              },
            ),
          );
        },
        child: const Text(
          'Learn Flutter',
          style: TextStyle(
            color: Color.fromARGB(255, 223, 233, 224),
          ),
        ),
      ),
    );
  }
}
