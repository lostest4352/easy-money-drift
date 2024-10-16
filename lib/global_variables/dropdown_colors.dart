import 'package:flutter/material.dart';

final class DropdownColors {
  final int colorsValue;
  final String colorsName;
  DropdownColors({
    required this.colorsValue,
    required this.colorsName,
  });
}

final List<DropdownColors> dropdownColorsList = [
  redColor,
  greenColor,
  blueColor,
  yellowColor,
  purpleColor,
  brownColor,
  pinkColor,
  orangeColor,
];

final redColor =
    DropdownColors(colorsName: "Red", colorsValue: Colors.red.value);
final greenColor =
    DropdownColors(colorsName: "Green", colorsValue: Colors.green.value);
final blueColor =
    DropdownColors(colorsName: "Blue", colorsValue: Colors.blue.value);
final yellowColor =
    DropdownColors(colorsName: "Yellow", colorsValue: Colors.yellow.value);
final purpleColor =
    DropdownColors(colorsName: "Purple", colorsValue: Colors.purple.value);
final brownColor =
    DropdownColors(colorsName: "Brown", colorsValue: Colors.brown.value);
final pinkColor =
    DropdownColors(colorsName: "Pink", colorsValue: Colors.pink.value);
final orangeColor =
    DropdownColors(colorsName: "Orange", colorsValue: Colors.orange.value);
