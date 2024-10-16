import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/database/drift_database.dart';
import 'package:flutter_expense_tracker/global_variables/time_range_global_vars.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final AppDatabase appDatabase;

  TransactionsBloc({required this.appDatabase}) : super(TransactionsInitial()) {
    final DateTime currentTimeExact = DateTime.now();
    final DateTime currentTime = DateTime(
      currentTimeExact.year,
      currentTimeExact.month,
      // Current day doesnt get shown when saved in endTime so added one day
      (currentTimeExact.day + 1),
    );

    on<TransactionsLoadedEvent>((event, emit) async {
      // All Time
      if (event.timeRangeState.buttonName == allTime) {
        final transactionListFromStream = appDatabase.getTransactionData();
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // This Month
      if (event.timeRangeState.buttonName == thisMonth) {
        final transactionListFromStream = appDatabase.getTransactionDataByDate(
          startTime: DateTime(
            currentTime.year,
            currentTime.month,
            1,
          ).toString(),
          endTime: currentTime.toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // Last Month
      if (event.timeRangeState.buttonName == lastMonth) {
        final transactionListFromStream = appDatabase.getTransactionDataByDate(
          startTime: DateTime(
            currentTime.year,
            currentTime.month - 1,
            1,
          ).toString(),
          endTime: DateTime(
            currentTime.year,
            currentTime.month,
            0,
          ).toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // Last 3 Months
      if (event.timeRangeState.buttonName == last3Months) {
        final transactionListFromStream = appDatabase.getTransactionDataByDate(
          startTime: DateTime(
            currentTime.year,
            currentTime.month - 2,
            1,
          ).toString(),
          endTime: currentTime.toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // Last 6 Months
      if (event.timeRangeState.buttonName == last6Months) {
        final transactionListFromStream = appDatabase.getTransactionDataByDate(
          startTime: DateTime(
            currentTime.year,
            currentTime.month - 5,
            1,
          ).toString(),
          endTime: currentTime.toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }

      // Custom
      if (event.timeRangeState.buttonName == customTimeRange) {
        if (event.timeRangeState.startTime != null &&
            event.timeRangeState.endTime != null) {
          final transactionListFromStream =
              appDatabase.getTransactionDataByDate(
            startTime: event.timeRangeState.startTime!,
            endTime: event.timeRangeState.endTime!,
          );
          await emit.forEach(
            transactionListFromStream,
            onData: (data) {
              return TransactionsLoadedState(listOfTransactionData: data);
            },
          );
        }
      }
    });

    on<TransactionsAddEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      isar.writeTxn(() async {
        await isar.transactionModelIsars.put(event.transactionModelIsar);
      });
    });

    on<TransactionsEditEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      final selectedUserModel = await isar.transactionModelIsars
          .get(event.selectedTransactionModelId);
      selectedUserModel?.amount = event.amount;
      selectedUserModel?.dateTime = event.dateTime;
      selectedUserModel?.note = event.note;
      //
      selectedUserModel?.transactionType = event.transactionType;
      selectedUserModel?.isIncome = event.isIncome;
      selectedUserModel?.colorsValue = event.colorsValue;
      //
      isar.writeTxn(() async {
        if (selectedUserModel != null) {
          await isar.transactionModelIsars.put(selectedUserModel);
        }
      });
    });

    on<TransactionsDeleteEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      isar.writeTxn(() async {
        await isar.transactionModelIsars
            .delete(event.widgetTransactionModelIsar!.id);
      });
    });
  }
}
