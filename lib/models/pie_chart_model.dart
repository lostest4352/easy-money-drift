import 'dart:convert';

class PieChartModel {
  int amount;
  //
  String transactionType;
  bool isIncome;
  int colorsValue;
  PieChartModel({
    required this.amount,
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'transactionType': transactionType,
      'isIncome': isIncome,
      'colorsValue': colorsValue,
    };
  }

  factory PieChartModel.fromMap(Map<String, dynamic> map) {
    return PieChartModel(
      amount: map['amount']?.toInt() ?? 0,
      transactionType: map['transactionType'] ?? '',
      isIncome: map['isIncome'] ?? false,
      colorsValue: map['colorsValue']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PieChartModel.fromJson(String source) =>
      PieChartModel.fromMap(json.decode(source));

  PieChartModel copyWith({
    int? amount,
    String? transactionType,
    bool? isIncome,
    int? colorsValue,
  }) {
    return PieChartModel(
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      isIncome: isIncome ?? this.isIncome,
      colorsValue: colorsValue ?? this.colorsValue,
    );
  }

  @override
  String toString() {
    return 'PieChartModel(amount: $amount, transactionType: $transactionType, isIncome: $isIncome, colorsValue: $colorsValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PieChartModel &&
        other.amount == amount &&
        other.transactionType == transactionType &&
        other.isIncome == isIncome &&
        other.colorsValue == colorsValue;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        transactionType.hashCode ^
        isIncome.hashCode ^
        colorsValue.hashCode;
  }
}
