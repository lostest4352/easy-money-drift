import 'package:flutter/foundation.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> isarDB;

  IsarService() {
    isarDB = openIsarDB();
  }

  Future<Isar> openIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();
    debugPrint("path is ${dir.path}");
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TransactionModelIsarSchema, CategoryModelIsarSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  // Transaction Related
  // Future<List<TransactionModelIsar>> getTransactionData() async {
  //   final isar = await isarDB;
  //   final getData = await isar.transactionModelIsars.where().findAll();
  //   return getData;
  // }

  Stream<List<TransactionModelIsar>> listenTransactionData() async* {
    final Isar isar = await isarDB;
    final listenToData =
        isar.transactionModelIsars.where().watch(fireImmediately: true);
    yield* listenToData;
  }

  Stream<List<TransactionModelIsar>> listenTransactionDateRange(
      {required String startTime, required String endTime}) async* {
    final Isar isar = await isarDB;

    final listenToData = isar.transactionModelIsars
        .where()
        .filter()
        .dateTimeBetween(startTime, endTime, caseSensitive: false)
        .watch(fireImmediately: true);
    yield* listenToData;
  }

  Stream<List<TransactionModelIsar>> listenTransactionSearchItem(
      {required String searchPattern}) async* {
    final Isar isar = await isarDB;

    final listenToData = isar.transactionModelIsars
        .where()
        .filter()
        .transactionTypeContains(searchPattern, caseSensitive: false)
        .watch(fireImmediately: true);
    yield* listenToData;
  }

  // Future<void> addTransactionData(
  //     TransactionModelIsar transactionModelIsar) async {
  //   final isar = await isarDB;
  //   isar.writeTxn(() async {
  //     isar.transactionModelIsars.put(transactionModelIsar);
  //   });
  // }

  // Future<void> editTransactionData(int selectedTransactionModelId, int amount,
  //     CategoryModelIsar categoryModelIsar, String dateTime, String note) async {
  //   final isar = await isarDB;
  //   final selectedUserModel =
  //       await isar.transactionModelIsars.get(selectedTransactionModelId);

  //   selectedUserModel?.amount = amount;
  //   selectedUserModel?.categoryModelIsar.value = categoryModelIsar;
  //   selectedUserModel?.dateTime = dateTime;
  //   selectedUserModel?.note = note;
  //   isar.writeTxn(() async {
  //     if (selectedUserModel != null) {
  //       isar.transactionModelIsars.put(selectedUserModel);
  //     }
  //   });
  // }

  // Future<void> deleteTransactionData(
  //     TransactionModelIsar widgetTransactionModelIsar) async {
  //   final isar = await isarDB;
  //   isar.writeTxn(() async {
  //     isar.transactionModelIsars.delete(widgetTransactionModelIsar.id);
  //   });
  // }

  // Category related

  // Future<List<CategoryModelIsar>> getCategoryData() async {
  //   final isar = await isarDB;
  //   final getData = await isar.categoryModelIsars.where().findAll();
  //   return getData;
  // }

  Stream<List<CategoryModelIsar>> listenCategoryData() async* {
    final isar = await isarDB;
    final listenToData =
        isar.categoryModelIsars.where().watch(fireImmediately: true);
    yield* listenToData;
  }

  // Future<void> addCategoryData(CategoryModelIsar categoryModelIsars) async {
  //   final isar = await isarDB;

  //   isar.writeTxn(() async {
  //     isar.categoryModelIsars.put(categoryModelIsars);
  //   });
  // }

  // Future<void> editCategoryData(
  //   CategoryModelIsar selectedCategoryModelIsar,
  //   int selectedCategoryModelId,
  //   String transactionType,
  //   bool isIncome,
  //   int colorsValue,
  // ) async {
  //   final isar = await isarDB;
  //   final selectedCategoryModel =
  //       await isar.categoryModelIsars.get(selectedCategoryModelId);

  //   selectedCategoryModel?.transactionType = transactionType;

  //   selectedCategoryModel?.isIncome = isIncome;
  //   selectedCategoryModel?.colorsValue = colorsValue;
  //   isar.writeTxn(() async {
  //     // if (selectedCategoryModel != null) {
  //     //   isar.categoryModelIsars.put(selectedCategoryModel);
  //     // }
  //     final filteredTransactionModelList = await isar.transactionModelIsars
  //         .where()
  //         .filter()
  //         .categoryModelIsar((q) => q.transactionTypeEqualTo(
  //             selectedCategoryModelIsar.transactionType))
  //         .findAll();
  //     if (filteredTransactionModelList.isEmpty) {
  //       if (selectedCategoryModel != null) {
  //         isar.categoryModelIsars.put(selectedCategoryModel);
  //       }
  //     }
  //   });
  // }

  // Future<void> deleteCategoryData(
  //     CategoryModelIsar selectedCategoryModelIsar) async {
  //   final isar = await isarDB;
  //   isar.writeTxn(() async {
  //     final filteredTransactionModelList = await isar.transactionModelIsars
  //         .where()
  //         .filter()
  //         .categoryModelIsar((q) => q.transactionTypeEqualTo(
  //             selectedCategoryModelIsar.transactionType))
  //         .findAll();
  //     if (filteredTransactionModelList.isEmpty) {
  //       isar.transactionModelIsars.delete(selectedCategoryModelIsar.id);
  //     }
  //   });
  // }

  // Delete all db items
  Future<void> cleanDB() async {
    final isar = await isarDB;
    isar.writeTxn(() async {
      isar.clear();
    });
  }
}
