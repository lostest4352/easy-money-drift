import '../../database/isar_classes.dart';

({int totalIncome, int totalExpense}) calculateTotalIncomeOrExpenses(
    List<TransactionModelIsar> snapshot) {
  int totalIncome = 0;
  int totalExpense = 0;

  for (final transactionItem in snapshot) {
    if (transactionItem.isIncome == true) {
      totalIncome += transactionItem.amount;
    } else {
      totalExpense += transactionItem.amount;
    }
  }
  return (totalIncome: totalIncome, totalExpense: totalExpense);
}

({int totalIncome, int totalExpense, int totalValue}) calculateTotalValue(
    List<TransactionModelIsar> transactionList) {
  int totalIncome = 0;
  int totalExpense = 0;
  int totalValue = 0;

  for (final transaction in transactionList) {
    if (transaction.isIncome == true) {
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
