import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const AppDrawer(),
      body: const Column(),
    );
  }
}
