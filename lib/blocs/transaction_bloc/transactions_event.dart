part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

final class TransactionsLoadedEvent extends TransactionsEvent {
  final TimeRangeState timeRangeState;

  TransactionsLoadedEvent({required this.timeRangeState});
}

final class TransactionsAddEvent extends TransactionsEvent {
  final TransactionModelDriftCompanion transactionModelDriftCompanion;

  TransactionsAddEvent({required this.transactionModelDriftCompanion});
}

final class TransactionsEditEvent extends TransactionsEvent {
  final TransactionModelDriftData transactionModelData;

  TransactionsEditEvent({required this.transactionModelData});
}

final class TransactionsDeleteEvent extends TransactionsEvent {
  final int transactionModelId;

  TransactionsDeleteEvent({
    required this.transactionModelId,
  });
}
