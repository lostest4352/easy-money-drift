import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/pages/category_page/category_modify_dialog.dart';

class ExpenseCategories extends StatefulWidget {
  const ExpenseCategories({super.key});

  @override
  State<ExpenseCategories> createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {
  final TextEditingController categoryController = TextEditingController();

  CategoryBloc get blocCategories => context.read<CategoryBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 29, 89, 192),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const CategoryModifyDialog(
                editMode: false,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        // remove this if any issues happen
        buildWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          const snackBar = SnackBar(
            duration: Duration(milliseconds: 1200),
            backgroundColor: Color.fromARGB(255, 29, 89, 192),
            content: Text(
              'Only unused cateories can be modified',
              style: TextStyle(color: Colors.white),
            ),
          );

          if (state.listOfCategoryData != null &&
              state.listOfCategoryData!.isEmpty) {
            debugPrint(
              "from listener length is ${state.listOfCategoryData?.length.toString()}",
            );
            blocCategories.add(CategoryAddDefaultItemsEvent());
          }

          if (state.snackBarStatus == SnackBarStatus.isShown) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          // If db doesnt support, add below like code for moving transactions to these two types if cateory deleted
          // blocCategories.listItems.where((itemsInList) {
          //   return itemsInList.transactionType == "otherIncome" ||
          //       itemsInList.transactionType == "otherExpense";
          // });

          final List<CategoryModelIsar>? categoryList =
              state.listOfCategoryData;

          if (categoryList == null) {
            return const Center(
              child: Text("No data"),
            );
          }

          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CategoryModifyDialog(
                              editMode: true,
                              selectedListItem: categoryList[index],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: categoryList[index].isIncome == true
                              ? Colors.blue
                              : Colors.red,
                          child: categoryList[index].isIncome == true
                              ? const Icon(
                                  Icons.addchart,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.highlight_remove_sharp,
                                  color: Colors.white,
                                ),
                        ),
                        title: Text(
                          categoryList[index].transactionType,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
