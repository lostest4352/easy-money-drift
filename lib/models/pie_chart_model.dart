import 'dart:convert';

import 'package:flutter_expense_tracker/models/category_model.dart';

class PieChartModel {
  int amount;
  //
  CategoryModel categoryModel;
  PieChartModel({
    required this.amount,
    required this.categoryModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'categoryModel': categoryModel.toMap(),
    };
  }

  factory PieChartModel.fromMap(Map<String, dynamic> map) {
    return PieChartModel(
      amount: map['amount']?.toInt() ?? 0,
      categoryModel: CategoryModel.fromMap(map['categoryModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PieChartModel.fromJson(String source) =>
      PieChartModel.fromMap(json.decode(source));

  PieChartModel copyWith({
    int? amount,
    CategoryModel? categoryModel,
  }) {
    return PieChartModel(
      amount: amount ?? this.amount,
      categoryModel: categoryModel ?? this.categoryModel,
    );
  }

  @override
  String toString() =>
      'PieChartModel(amount: $amount, categoryModel: $categoryModel)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PieChartModel &&
        other.amount == amount &&
        other.categoryModel == categoryModel;
  }

  @override
  int get hashCode => amount.hashCode ^ categoryModel.hashCode;
}
