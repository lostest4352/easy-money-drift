import 'package:flutter/material.dart';

class PopupCategoryItems extends StatelessWidget {
  final String title;
  const PopupCategoryItems({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(55),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}