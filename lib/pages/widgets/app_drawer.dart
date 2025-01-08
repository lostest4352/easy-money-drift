import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/pages/category_page/expense_categories.dart';
import 'package:flutter_expense_tracker/pages/home_page/home_page.dart';
import 'package:flutter_expense_tracker/pages/settings_page/settings_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      width: () {
        if (Platform.isWindows) {
          return 270.0;
        }
      }(),
      child: ListView(
        children: [
          const DrawerHeader(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: Column(
              children: [
                Spacer(),
                Text(
                  "Easy Money",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Expense tracker",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ));
            },
            leading: const Icon(Icons.account_balance_outlined),
            title: const Text(
              'Transactions',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ExpenseCategories();
                },
              ));
            },
            leading: const Icon(Icons.label),
            title: const Text(
              'Categories',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SettingsPage();
                },
              ));
            },
            leading: const Icon(Icons.settings),
            title: const Text(
              'Settings',
            ),
          ),
        ],
      ),
    );
  }
}
