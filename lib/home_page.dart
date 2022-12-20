import 'package:flutter/material.dart';
//import 'package:flutter_test_app/learn_flutter_page.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Center(
      child: Checkbox(
          value: themeChange.darkTheme,
          onChanged: (value) {
            themeChange.darkTheme = value!;
          }),

      /** ElevatedButton(
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
      */
    );
  }
}
