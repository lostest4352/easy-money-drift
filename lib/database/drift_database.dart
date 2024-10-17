import 'dart:io';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:path/path.dart' as p;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_expense_tracker/database/categories_type_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/extensions/json1.dart';

part 'drift_database.g.dart';

class TransactionModelDrift extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get dateAndTime =>
      text()(); // dateTime is already a drift's variable
  IntColumn get amount => integer()();
  TextColumn get note => text().nullable()();
  //
  TextColumn get categoryModel => text().map(const CategoryConverter())();
}

class CategoryModelDrift extends Table {
  IntColumn get id => integer().autoIncrement()();
  //
  TextColumn get categoryModel => text().map(const CategoryConverter())();
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
            // may cause issues. from: https://github.com/simolus3/drift/issues/2734
            // return val.categoryModel
            //     .jsonExtract(r"$.transactionType")
            //     .equals(keyword);
            return val.categoryModel.contains(keyword);
          })
          ..orderBy([
            (transaction) => OrderingTerm(
                expression: transaction.id, mode: OrderingMode.desc)
          ]))
        .watch();
    yield* allTransactions;
  }

  Future<int> addTransaction(TransactionModelDriftCompanion entry) {
    final addEntry = into(transactionModelDrift).insert(entry);
    return addEntry;
  }

  Future<int> createOrUpdateTransaction(
      TransactionModelDriftData transactionModelData) {
    //
    final updateEntry = into(transactionModelDrift)
        .insertOnConflictUpdate(transactionModelData);
    return updateEntry;
  }

  Future<int> deleteTransaction(int transactionModelId) {
    final deleteEntry = (delete(transactionModelDrift)
          ..where((tbl) => tbl.id.equals(transactionModelId)))
        .go();
    return deleteEntry;
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

  Future<int> addCategory(CategoryModelDriftCompanion entry) {
    final addEntry = into(categoryModelDrift).insert(entry);
    return addEntry;
  }

  // TODO
  Future<int> editCategory(CategoryModel categoryModel) async {
    //
    // returns only the transactionqueries that doesnt have the selected category model
    final ifNotExist = notExistsQuery(select(transactionModelDrift)
      ..where((row) => row.categoryModel.equalsValue(categoryModel)));

    final editValue = (update(categoryModelDrift)
          ..where((tbl) {
            // TODO here
            debugPrint(tbl.categoryModel.toString());
            debugPrint(categoryModel.toString());
            return ifNotExist & tbl.categoryModel.equalsValue(categoryModel);
          }))
        .write(
            CategoryModelDriftCompanion(categoryModel: Value(categoryModel)));

    // TODO
    final editval = await editValue;
    debugPrint(editval.toString());
    return editValue;
  }

  // TODO
  Future<int> deleteCategory(CategoryModel categoryModel) async {
    //
    // returns only the transactionqueries that doesnt have the selected category model
    final ifNotExist = notExistsQuery(select(transactionModelDrift)
      ..where((row) => row.categoryModel.equalsValue(categoryModel)));

    // delete only the category models that doesnt exist on transaction table
    final deleteEntry = (delete(categoryModelDrift)
          ..where((tbl) =>
              ifNotExist & tbl.categoryModel.equalsValue(categoryModel)))
        .go();
    final intValue = await deleteEntry;
    debugPrint(intValue.toString());
    return deleteEntry;
  }

  Future<void> addDefaultItems(
      List<CategoryModelDriftCompanion>
          listOfCategoryModelDriftCompanion) async {
    await (batch((batch) {
      batch.insertAll(categoryModelDrift, listOfCategoryModelDriftCompanion);
    }));
  }

  // TODO may do delete all
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
