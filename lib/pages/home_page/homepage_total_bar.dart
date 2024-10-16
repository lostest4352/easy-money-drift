import 'package:flutter/material.dart';

class HomePageTotalBar extends StatelessWidget {
  final int income;
  final int expenses;
  const HomePageTotalBar({
    Key? key,
    required this.income,
    required this.expenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0x33BDE9FF),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text("Income: Rs. $income"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text("Expenses: Rs. $expenses"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text("Balance: Rs. ${income - expenses}"),
            ),
          ],
        ),
      ),
    );
  }
}