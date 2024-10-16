import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/pages/home_page/graphs_page.dart';
import 'package:flutter_expense_tracker/pages/home_page/home_page.dart';
import 'package:flutter_expense_tracker/pages/widgets/keep_pages_alive.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  List<Widget> allPages = [
    const KeepPagesAlive(
      child: HomePage(),
    ),
    const KeepPagesAlive(
      child: GraphsPage(),
    ),
  ];

  void changePage(int value) {
    setState(() {
      currentPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allPages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,

        /// same as (value) {changePage(value);}
        onTap: changePage,
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Graphs',
          ),
        ],
      ),
    );
  }
}
