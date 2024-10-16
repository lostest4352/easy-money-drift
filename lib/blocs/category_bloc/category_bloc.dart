import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:flutter_expense_tracker/global_variables/dropdown_colors.dart';
import 'package:isar/isar.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final IsarService isarService;

  CategoryBloc({required this.isarService})
      // make initial data [] if any issue happens
      : super(CategoryState(listOfCategoryData: null)) {
    on<CategoryInitialEvent>((event, emit) async {
      final categoryListFromStream = isarService.listenCategoryData();
      await emit.forEach(
        categoryListFromStream,
        onData: (data) {
          return state.copyWith(
            listOfCategoryData: data,
            snackBarStatus: SnackBarStatus.isNotShown,
          );
          // return CategoryState(listOfCategoryData: data);
        },
      );
    });

    on<CategoryAddEvent>((event, emit) async {
      final Isar isar = await isarService.isarDB;
      await isar.writeTxn(() async {
        await isar.categoryModelIsars.put(event.categoryModelIsars);
        // emit(state.copyWith(snackBarStatus: SnackBarStatus.isNotShown));
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    });

    on<CategoryEditEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      final selectedCategoryModel =
          await isar.categoryModelIsars.get(event.selectedCategoryModelId);
      selectedCategoryModel?.transactionType = event.transactionType;
      selectedCategoryModel?.isIncome = event.isIncome;
      selectedCategoryModel?.colorsValue = event.colorsValue;
      await isar.writeTxn(() async {
        final filteredTransactionModelList = await isar.transactionModelIsars
            .where()
            .filter()
            .transactionTypeEqualTo(
                event.selectedCategoryModelIsar.transactionType)
            .findAll();
        if (filteredTransactionModelList.isEmpty) {
          if (selectedCategoryModel != null) {
            await isar.categoryModelIsars.put(selectedCategoryModel);
            // emit(state.copyWith(snackBarStatus: SnackBarStatus.isNotShown));
          }
        } else {
          emit(state.copyWith(snackBarStatus: SnackBarStatus.isShown));
          await Future.delayed(Duration.zero);
          emit(state.copyWith(snackBarStatus: SnackBarStatus.isNotShown));
        }
      });
    });

    on<CategoryDeleteEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      await isar.writeTxn(() async {
        final filteredTransactionModelList = await isar.transactionModelIsars
            .where()
            .filter()
            .transactionTypeEqualTo(
                event.selectedCategoryModelIsar.transactionType)
            .findAll();
        if (filteredTransactionModelList.isEmpty) {
          await isar.categoryModelIsars
              .delete(event.selectedCategoryModelIsar.id);
          // emit(state.copyWith(snackBarStatus: SnackBarStatus.isNotShown));
        } else {
          emit(state.copyWith(snackBarStatus: SnackBarStatus.isShown));
          await Future.delayed(Duration.zero);
          emit(state.copyWith(snackBarStatus: SnackBarStatus.isNotShown));
        }
      });
    });

    on<CategoryAddDefaultItemsEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      await isar.writeTxn(() async {
        await isar.categoryModelIsars.putAll(defaultListItems);
        // emit(state.copyWith(snackBarStatus: SnackBarStatus.isNotShown));
      });
    });
  }

  final defaultListItems = [
    CategoryModelIsar()
      ..transactionType = "Clothing"
      ..isIncome = false
      ..colorsValue = purpleColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Entertainment"
      ..isIncome = false
      ..colorsValue = redColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Health"
      ..isIncome = false
      ..colorsValue = blueColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Fuel"
      ..isIncome = false
      ..colorsValue = yellowColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Food"
      ..isIncome = false
      ..colorsValue = greenColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Salary"
      ..isIncome = true
      ..colorsValue = blueColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Bonus"
      ..isIncome = true
      ..colorsValue = redColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Wages"
      ..isIncome = true
      ..colorsValue = greenColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Gifts"
      ..isIncome = true
      ..colorsValue = purpleColor.colorsValue,
  ];
}
