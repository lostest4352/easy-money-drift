import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/drift_database.dart';
import 'package:flutter_expense_tracker/global_variables/dropdown_colors.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AppDatabase appDatabase;

  CategoryBloc({required this.appDatabase})
      // make initial data [] if any issue happens
      : super(CategoryState(listOfCategoryData: null)) {
    on<CategoryInitialEvent>((event, emit) async {
      final categoryListFromStream = appDatabase.getCategoryData();
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
      appDatabase.addCategory(event.categoryModelDriftCompanion);
    });

    on<CategoryEditEvent>((event, emit) async {
      appDatabase.editCategory(event.categoryModel);
    });

    on<CategoryDeleteEvent>((event, emit) async {
      appDatabase.deleteCategory(event.categoryModel);
    });

    on<CategoryAddDefaultItemsEvent>((event, emit) async {
      appDatabase.addDefaultItems(defaultCategoryItems);
    });
  }

  final defaultCategoryItems = [
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Clothing",
        isIncome: false,
        colorsValue: purpleColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Entertainment",
        isIncome: false,
        colorsValue: redColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Health",
        isIncome: false,
        colorsValue: blueColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Fuel",
        isIncome: false,
        colorsValue: yellowColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Food",
        isIncome: false,
        colorsValue: greenColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Salary",
        isIncome: true,
        colorsValue: blueColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Bonus",
        isIncome: true,
        colorsValue: redColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Wages",
        isIncome: true,
        colorsValue: greenColor.colorsValue,
      ),
    ),
    CategoryModelDriftCompanion.insert(
      categoryModel: CategoryModel(
        transactionType: "Gifts",
        isIncome: true,
        colorsValue: purpleColor.colorsValue,
      ),
    ),
  ];

  // final defaultListItems = [
  //   CategoryModelIsar()
  //     ..transactionType = "Clothing"
  //     ..isIncome = false
  //     ..colorsValue = purpleColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Entertainment"
  //     ..isIncome = false
  //     ..colorsValue = redColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Health"
  //     ..isIncome = false
  //     ..colorsValue = blueColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Fuel"
  //     ..isIncome = false
  //     ..colorsValue = yellowColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Food"
  //     ..isIncome = false
  //     ..colorsValue = greenColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Salary"
  //     ..isIncome = true
  //     ..colorsValue = blueColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Bonus"
  //     ..isIncome = true
  //     ..colorsValue = redColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Wages"
  //     ..isIncome = true
  //     ..colorsValue = greenColor.colorsValue,
  //   CategoryModelIsar()
  //     ..transactionType = "Gifts"
  //     ..isIncome = true
  //     ..colorsValue = purpleColor.colorsValue,
  // ];
}
