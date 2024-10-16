import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_expense_tracker/database/categories.dart';
import 'package:path_provider/path_provider.dart';

part 'drift_database.g.dart';

class TransactionModelDrift extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get dateAndTime =>
      text()(); // dateTime is already a drift's variable
  IntColumn get amount => integer()();
  //
  TextColumn get categoryModel =>
      text().map(const CategoryConverter()).nullable()();
}

class CategoryModelDrift extends Table {
  //
  TextColumn get categoryModel =>
      text().map(const CategoryConverter()).nullable()();
}

@DriftDatabase(tables: [TransactionModelDrift, CategoryModelDrift])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  //Transaction related
  Stream<List<TransactionModelDriftData>> getTransactionData() async* {
    final allTransactions = (select(transactionModelDrift)
          ..orderBy([
            (transaction) => OrderingTerm(
                expression: transaction.id, mode: OrderingMode.desc)
          ]))
        .watch();
    yield* allTransactions;
  }

  Stream<List<TransactionModelDriftData>> getTransactionDataByDate(
      {required String startTime, required String endTime}) async* {
    final allTransactions = (select(transactionModelDrift)
          ..where((val) => val.dateAndTime.isBetweenValues(startTime, endTime))
          ..orderBy([
            (transaction) => OrderingTerm(
                expression: transaction.dateAndTime, mode: OrderingMode.desc)
          ]))
        .watch();
    yield* allTransactions;
  }

  Stream<List<TransactionModelDriftData>> getTransactionDataSearchItem(
      {required String keyword}) async* {
    final allTransactions = (select(transactionModelDrift)
          ..where((val) {
            // may cause issues
            return val.categoryModel.contains(keyword);
          })
          ..orderBy([
            (transaction) => OrderingTerm(
                expression: transaction.id, mode: OrderingMode.desc)
          ]))
        .watch();
    yield* allTransactions;
  }

  // Category related
  Stream<List<CategoryModelDriftData>> getCategoryData() async* {
    final allCategories = (select(categoryModelDrift)
          ..orderBy([
            (cateories) => OrderingTerm(
                expression: cateories.categoryModel, mode: OrderingMode.desc)
          ]))
        .watch();
    yield* allCategories;
  }

  // TODO may do delete
}

//
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final docDir = await getApplicationDocumentsDirectory();
    // final file = File(p.join(dbFolder.path, 'db.sqlite')); // if no directory
    final dbFolder = Directory(p.join(docDir.path, 'appdb'));
    await dbFolder.create(recursive: true);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    debugPrint(dbFolder.path);

    return NativeDatabase.createInBackground(file);
  });
}
