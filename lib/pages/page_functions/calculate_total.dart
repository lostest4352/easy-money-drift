import 'package:flutter_expense_tracker/database/drift_database.dart';

({int totalIncome, int totalExpense}) calculateTotalIncomeOrExpenses(
    List<TransactionModelDriftData> snapshot) {
  int totalIncome = 0;
  int totalExpense = 0;

  for (final transactionItem in snapshot) {
    if (transactionItem.categoryModel?.isIncome == true) {
      totalIncome += transactionItem.amount;
    } else {
      totalExpense += transactionItem.amount;
    }
  }
  return (totalIncome: totalIncome, totalExpense: totalExpense);
}

({int totalIncome, int totalExpense, int totalValue}) calculateTotalValue(
    List<TransactionModelDriftData> transactionList) {
  int totalIncome = 0;
  int totalExpense = 0;
  int totalValue = 0;

  for (final transaction in transactionList) {
    if (transaction.categoryModel?.isIncome == true) {
      totalIncome += transaction.amount;
    } else {
      totalExpense -= transaction.amount;
    }
  }
  totalValue = totalIncome + totalExpense;
  return (
    totalIncome: totalIncome,
    totalExpense: totalExpense,
    totalValue: totalValue,
  );
}
