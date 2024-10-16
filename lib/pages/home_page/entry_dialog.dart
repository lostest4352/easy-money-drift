import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/pages/category_page/category_modify_dialog.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_category_items.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_items.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_title.dart';

class EntryDialog extends StatefulWidget {
  final bool editMode;
  final TransactionModelIsar? transaction;
  const EntryDialog({
    Key? key,
    required this.editMode,
    this.transaction,
  }) : super(key: key);

  @override
  State<EntryDialog> createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  // Text Controllers
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Date Related
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String get formattedDate => formatter.format(selectedDate);

  // Current date unchanged unlike above
  final String currentDateFormatted =
      DateFormat('yyyy-MM-dd').format(DateTime.now());

  String? transactionType;
  bool? isIncome;
  int? colorsValue;

  @override
  void initState() {
    super.initState();
    if (widget.editMode == true) {
      amountController.text = widget.transaction?.amount.toString() ?? "";
      noteController.text = widget.transaction?.note ?? "";
      selectedDate = DateTime.parse(widget.transaction!.dateTime);
      //
      transactionType = widget.transaction?.transactionType ?? "";
      isIncome = widget.transaction?.isIncome ?? true;
      colorsValue = widget.transaction?.colorsValue;
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  TransactionsBloc get blocTransaction => context.read<TransactionsBloc>();
  IsarService get isarService => context.read<IsarService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          backgroundColor: Colors.grey.shade900,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  () {
                    if (widget.editMode == true) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            blocTransaction.add(
                              TransactionsDeleteEvent(
                                widgetTransactionModelIsar: widget.transaction,
                              ),
                            );
                            context.pop();
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }(),
                  const SizedBox(
                    height: 15,
                  ),
                  const PopupTextFieldTitle(
                    title: "Date",
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.editMode == false) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TableCalendar(
                                    firstDay: DateTime.utc(2010, 01, 01),
                                    lastDay: DateTime.now(),
                                    availableCalendarFormats: const {
                                      CalendarFormat.month: 'Month',
                                    },
                                    focusedDay: selectedDate,
                                    onDaySelected: (selectedDay, focusedDay) {
                                      setState(() {
                                        selectedDate = selectedDay;
                                      });
                                      context.pop();
                                    },
                                    selectedDayPredicate: (day) {
                                      return isSameDay(selectedDate, day);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: PopupCategoryItems(
                      title: (formattedDate == currentDateFormatted)
                          ? "Today"
                          : formattedDate.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const PopupTextFieldTitle(
                    title: "Amount",
                  ),
                  PopupTextFieldItems(
                    textEditingController: amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    inputFormatters: [
                      // FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}')),
                    ],
                    hintText: "Enter Amount",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.red.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            if (transactionType != null &&
                                isIncome != null &&
                                colorsValue != null) {
                              TransactionModelIsar transactionModelIsar =
                                  TransactionModelIsar()
                                    ..amount = int.parse(amountController.text)
                                    ..dateTime = selectedDate.toString()
                                    ..note = (noteController.text.trim() == "")
                                        ? null
                                        : noteController.text.trim()
                                    //
                                    ..transactionType = transactionType ?? ""
                                    ..isIncome = isIncome ?? true
                                    ..colorsValue =
                                        colorsValue ?? Colors.red.value;
                              if (widget.editMode == false) {
                                blocTransaction.add(
                                  TransactionsAddEvent(
                                    transactionModelIsar: transactionModelIsar,
                                  ),
                                );
                              } else {
                                blocTransaction.add(
                                  TransactionsEditEvent(
                                    selectedTransactionModelId:
                                        widget.transaction!.id,
                                    amount: int.parse(amountController.text),
                                    dateTime: selectedDate.toString(),
                                    note: (noteController.text.trim() == "")
                                        ? null
                                        : noteController.text.trim(),
                                    //
                                    transactionType: transactionType!,
                                    isIncome: isIncome!,
                                    colorsValue: colorsValue!,
                                  ),
                                );
                              }
                            }
                            context.pop();
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.blue.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const PopupTextFieldTitle(
                    title: "Category",
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
                              height: 400,
                              child: BlocBuilder<CategoryBloc, CategoryState>(
                                builder: (context, state) {
                                  if (state.listOfCategoryData != null) {
                                    CategoryBloc blocCategories =
                                        context.read<CategoryBloc>();
                                    final categoryList = state.listOfCategoryData;
            
                                    if (categoryList!.isEmpty) {
                                      blocCategories
                                          .add(CategoryAddDefaultItemsEvent());
                                    }
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: categoryList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    transactionType =
                                                        categoryList[index]
                                                            .transactionType;
                                                    isIncome = categoryList[index]
                                                        .isIncome;
                                                    colorsValue =
                                                        categoryList[index]
                                                            .colorsValue;
                                                  });
                                                  context.pop();
                                                },
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      (categoryList[index]
                                                                  .isIncome) ==
                                                              true
                                                          ? Colors.blue
                                                          : Colors.red,
                                                  child: (categoryList[index]
                                                              .isIncome ==
                                                          true)
                                                      ? const Icon(
                                                          Icons.addchart,
                                                          color: Colors.white,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .highlight_remove_sharp,
                                                          color: Colors.white,
                                                        ),
                                                ),
                                                //
                                                title: Text(
                                                  categoryList[index]
                                                      .transactionType,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, bottom: 8),
                                              child: TextButton(
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
                                                child: const Text(
                                                  "+Add item",
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("No Data"),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: PopupCategoryItems(
                      title: transactionType ?? "Select Category",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const PopupTextFieldTitle(
                    title: "Note",
                  ),
                  PopupTextFieldItems(
                    textEditingController: noteController,
                    hintText: "Note(Optional)",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
