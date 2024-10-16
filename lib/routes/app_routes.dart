import 'package:flutter_expense_tracker/pages/category_page/categories.dart';
import 'package:flutter_expense_tracker/pages/home_page/search_page.dart';
import 'package:flutter_expense_tracker/pages/main_page.dart';
import 'package:flutter_expense_tracker/pages/settings_page/settings_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  homePage,
  expenseCategoriesPage,
  settingsPage,
  searchPage,
}

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: AppRoutes.homePage.name,
      path: '/',
      builder: (context, state) {
        return const MainPage();
      },
      // routes: [],
    ),
    GoRoute(
      name: AppRoutes.expenseCategoriesPage.name,
      path: '/categories',
      builder: (context, state) {
        return const ExpenseCategories();
      },
    ),
    GoRoute(
      name: AppRoutes.settingsPage.name,
      path: '/settingsPage',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
    GoRoute(
      name: AppRoutes.searchPage.name,
      path: '/searchPage',
      builder: (context, state) {
        return const SearchPage();
      },
    ),
  ],
);
