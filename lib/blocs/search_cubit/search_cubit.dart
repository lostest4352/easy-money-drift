import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_expense_tracker/database/drift_database.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  StreamSubscription? _streamSubscription;
  final AppDatabase appDatabase;
  SearchCubit({required this.appDatabase}) : super(SearchInitial());

  void searchClicked(String searchPattern) {
    _streamSubscription?.cancel(); // Remove later if issues occur
    // _streamSubscription = isarService
    //     .listenTransactionSearchItem(searchPattern: searchPattern)
    //     .listen((listOfTransactions) {
    //   emit(SearchLoadedState(listOfTransactionData: listOfTransactions));
    // });
    _streamSubscription =
        appDatabase.getTransactionDataSearchItem(keyword: searchPattern).listen(
      (listOfTransactions) {
        emit(SearchLoadedState(listOfTransactionData: listOfTransactions));
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
