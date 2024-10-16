part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

final class TransactionsLoadedState extends TransactionsState
    with EquatableMixin {
  final List<TransactionModelIsar>? listOfTransactionData;

  TransactionsLoadedState({required this.listOfTransactionData});

  @override
  List<Object?> get props => [listOfTransactionData];
}
