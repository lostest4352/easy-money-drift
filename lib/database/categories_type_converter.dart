import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';

// Type Converter related
class CategoryConverter extends TypeConverter<CategoryModel, String>
    with JsonTypeConverter<CategoryModel, String> {
  //
  const CategoryConverter();
  //
  @override
  CategoryModel fromSql(String fromDb) {
    return CategoryModel.fromMap(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(CategoryModel value) {
    return json.encode(value.toMap());
  }
}
