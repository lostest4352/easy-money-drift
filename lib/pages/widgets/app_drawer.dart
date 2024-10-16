import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

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
              context.goNamed(AppRoutes.homePage.name);
            },
            leading: const Icon(Icons.account_balance_outlined),
            title: const Text(
              'Transactions',
            ),
          ),
          ListTile(
            onTap: () {
              context.goNamed(AppRoutes.expenseCategoriesPage.name);
            },
            leading: const Icon(Icons.label),
            title: const Text(
              'Categories',
            ),
          ),
          ListTile(
            onTap: () {
              context.goNamed(AppRoutes.settingsPage.name);
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
