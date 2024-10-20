import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/database/drift_database.dart';
import 'package:flutter_expense_tracker/global_variables/dropdown_colors.dart';

import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_items.dart';
import 'package:go_router/go_router.dart';

class CategoryModifyDialog extends StatefulWidget {
  final bool editMode;
  final CategoryModelDriftData? selectedListItem;
  const CategoryModifyDialog({
    super.key,
    required this.editMode,
    this.selectedListItem,
  });

  @override
  State<CategoryModifyDialog> createState() => _CategoryModifyDialogState();
}

class _CategoryModifyDialogState extends State<CategoryModifyDialog> {
  ValueNotifier<bool?> isIncome = ValueNotifier(null);
  // late int colorsValue;
  ValueNotifier<int?> colorsValue = ValueNotifier(null);
  final TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final selectedListItems = widget.selectedListItem;
    if (selectedListItems != null) {
      categoryController.text = selectedListItems.categoryModel.transactionType;
      isIncome.value = selectedListItems.categoryModel.isIncome;
      colorsValue.value = selectedListItems.categoryModel.colorsValue;
    } else {
      categoryController.text = "";
      isIncome.value = true;
      colorsValue.value = Colors.red.value;
    }
  }

  @override
  void dispose() {
    categoryController.dispose();
    isIncome.dispose();
    super.dispose();
  }

  CategoryBloc get blocCategories => context.read<CategoryBloc>();
  TransactionsBloc get blocTransactions => context.read<TransactionsBloc>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: ListenableBuilder(
          listenable: colorsValue,
          builder: (context, colorsChild) {
            return ListenableBuilder(
              listenable: isIncome,
              builder: (context, isIncomeChild) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupTextFieldItems(
                        textEditingController: categoryController,
                        hintText: "Enter Category Name",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Row(
                        children: [
                          const Text("Transaction Type"),
                          const Spacer(),
                          DropdownButton(
                            value: isIncome.value,
                            items: const [
                              DropdownMenuItem(
                                value: true,
                                child: Text("Income"),
                              ),
                              DropdownMenuItem(
                                value: false,
                                child: Text("Expense"),
                              ),
                            ],
                            onChanged: (value) {
                              isIncome.value = value ?? true;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Row(
                        children: [
                          const Text("Select Color"),
                          const Spacer(),
                          DropdownButton(
                            value: colorsValue.value,
                            items: [
                              for (final dropdownColors in dropdownColorsList)
                                DropdownMenuItem(
                                  value: dropdownColors.colorsValue,
                                  child: Text(dropdownColors.colorsName),
                                ),
                            ],
                            onChanged: (value) {
                              colorsValue.value = value ?? Colors.red.value;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            children: [
                              Builder(
                                builder: (context) {
                                  if (widget.editMode == true) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actions: [
                                                const Wrap(
                                                  children: [
                                                    Text(
                                                      "Are you sure that you want to delete this category?",
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        final model = widget
                                                            .selectedListItem
                                                            ?.categoryModel;
                                                        if (model != null) {
                                                          blocCategories.add(
                                                            CategoryDeleteEvent(
                                                              categoryModel:
                                                                  model,
                                                            ),
                                                          );
                                                        }

                                                        context.pop();
                                                        context.pop();
                                                      },
                                                      child: const Text(
                                                        "Ok",
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text("Delete"),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              const Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  if (categoryController.text.isNotEmpty) {
                                    //
                                    final model = CategoryModel(
                                        transactionType:
                                            categoryController.text,
                                        isIncome: isIncome.value ?? true,
                                        colorsValue: colorsValue.value ??
                                            redColor.colorsValue);
                                    final driftCompanion =
                                        CategoryModelDriftCompanion.insert(
                                            categoryModel: model);
                                    if (widget.editMode == false) {
                                      blocCategories.add(
                                        CategoryAddEvent(
                                            categoryModelDriftCompanion:
                                                driftCompanion),
                                      );
                                      context.pop();
                                    } else if (widget.editMode == true) {
                                      //
                                      //old model
                                      final oldModel = widget
                                          .selectedListItem?.categoryModel;

                                      // new model
                                      final newModel = CategoryModel(
                                          transactionType:
                                              categoryController.text,
                                          isIncome: isIncome.value ?? true,
                                          colorsValue: colorsValue.value ??
                                              redColor.colorsValue);

                                      if (oldModel != null) {
                                        blocCategories.add(CategoryEditEvent(
                                            oldCategoryModel: oldModel,
                                            newCategoryModel: newModel));
                                      }

                                      context.pop();
                                    }
                                  }
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
