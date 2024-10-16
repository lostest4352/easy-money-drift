import 'dart:convert';

import 'package:drift/drift.dart';

class CategoryModel {
  String transactionType;
  bool isIncome;
  int colorsValue;
  CategoryModel({
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
  });

  CategoryModel copyWith({
    String? transactionType,
    bool? isIncome,
    int? colorsValue,
  }) {
    return CategoryModel(
      transactionType: transactionType ?? this.transactionType,
      isIncome: isIncome ?? this.isIncome,
      colorsValue: colorsValue ?? this.colorsValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionType': transactionType,
      'isIncome': isIncome,
      'colorsValue': colorsValue,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      transactionType: map['transactionType'] ?? '',
      isIncome: map['isIncome'] ?? false,
      colorsValue: map['colorsValue']?.toInt() ?? 0,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CategoryModel(transactionType: $transactionType, isIncome: $isIncome, colorsValue: $colorsValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.transactionType == transactionType &&
        other.isIncome == isIncome &&
        other.colorsValue == colorsValue;
  }

  @override
  int get hashCode =>
      transactionType.hashCode ^ isIncome.hashCode ^ colorsValue.hashCode;
}

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
