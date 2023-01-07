import '../services/storage_manager.dart';

import 'package:flutter/material.dart';
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
    );
  }
}
