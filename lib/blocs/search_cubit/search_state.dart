part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState {}

final class SearchLoadedState extends SearchState {
  final List<TransactionModelIsar>? listOfTransactionData;

  const SearchLoadedState({required this.listOfTransactionData});
}
