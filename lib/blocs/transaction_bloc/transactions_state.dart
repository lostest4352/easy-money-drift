part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

final class TransactionsLoadedState extends TransactionsState
    with EquatableMixin {
  final List<TransactionModelDriftData>? listOfTransactionData;

  TransactionsLoadedState({required this.listOfTransactionData});

  maj() {
    TransactionModelDrift val = TransactionModelDrift();
    val.categoryModel;
  }

  @override
  List<Object?> get props => [listOfTransactionData];
}
