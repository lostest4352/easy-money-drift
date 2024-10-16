import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_expense_tracker/database/transaction.dart';
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

  //
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
