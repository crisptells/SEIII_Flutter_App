import '../services/storage_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 70,
        ),
        Container(
          alignment: Alignment.center,
          child: Icon(
            Icons.school,
            color: Theme.of(context).iconTheme.color,
            size: 300,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "StudyRight",
            style: TextStyle(color: Theme.of(context).iconTheme.color, fontSize: 42, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
