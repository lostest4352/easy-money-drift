import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/global_variables/time_range_global_vars.dart';
import 'package:flutter_expense_tracker/pages/home_page/date_custom_select.dart';
import 'package:flutter_expense_tracker/pages/home_page/date_fixed_range_select.dart';
import 'package:flutter_expense_tracker/pages/page_functions/date_formatter.dart';
import 'package:flutter_expense_tracker/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/pages/home_page/entry_dialog.dart';
import 'package:flutter_expense_tracker/pages/home_page/homepage_total_bar.dart';
import 'package:flutter_expense_tracker/pages/home_page/transaction_view.dart';
import 'package:flutter_expense_tracker/pages/page_functions/calculate_total.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> bottomOpen = ValueNotifier(false);
  final DateTime currentTime = DateTime.now();
  //
  String get titleText => context.read<TimeRangeCubit>().state.buttonName;

  @override
  void dispose() {
    bottomOpen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: bottomOpen,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            bottom: () {
              if (bottomOpen.value == true) {
                return PreferredSize(
                  // preferredSize: const Size.fromHeight(200),
                  preferredSize: () {
                    if (Platform.isWindows) {
                      return const Size.fromHeight(130);
                    } else {
                      return const Size.fromHeight(200);
                    }
                  }(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Spacer(),
                            // This month
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: thisMonth,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            // Last month
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: lastMonth,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Spacer(),
                            // Last 3 months
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: last3Months,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            // Last 6 months
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: last6Months,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Spacer(),
                            // All Time
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: allTime,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            // Seperate for this one
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: () {
                                  if (titleText == customTimeRange) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.transparent;
                                  }
                                }(),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDateDialog(
                                      bottomOpen: bottomOpen,
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                customTimeRange,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }(),
            title: InkWell(
              onTap: () {
                bottomOpen.value = !bottomOpen.value;
              },
              child: Row(
                children: [
                  Text(
                    titleText,
                  ),
                  if (bottomOpen.value == false)
                    const Icon(Icons.arrow_drop_down)
                  else
                    const Icon(Icons.arrow_drop_up),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.searchPage.name);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const EntryDialog(editMode: false);
                },
              );
            },
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.add),
          ),
          drawer: const AppDrawer(),
          body: BlocBuilder<TransactionsBloc, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsLoadedState) {
                //
                final transactionsList = state.listOfTransactionData;
                transactionsList
                    ?.sort((a, b) => b.dateTime.compareTo(a.dateTime));

                // Code for sorting ascending/descending
                // snapshot.data!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
                // sort date
                // snapshot.data!.sort((a, b) => b.dateTime.compareTo(a.dateTime));
                // get calculated value
                final calculatedValue =
                    calculateTotalIncomeOrExpenses(transactionsList!);
                //
                final groupByMonth = groupBy(transactionsList, (obj) {
                  final objectDateTime =
                      DateTime.parse(obj.dateTime).formatMonth();
                  return objectDateTime;
                });
                return Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    HomePageTotalBar(
                      income: calculatedValue.totalIncome,
                      expenses: calculatedValue.totalExpense,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemCount: groupByMonth.length,
                        itemBuilder: (context, index) {
                          final List<TransactionModelIsar> monthEntryValue =
                              groupByMonth.values.toList()[index];
                          final String monthEntryKey =
                              groupByMonth.keys.toList()[index];
                          return Column(
                            children: [
                              () {
                                final calculatedMonthData = calculateTotalValue(
                                  monthEntryValue,
                                );
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  child: Column(
                                    children: [
                                      Text(
                                        // key is month name
                                        monthEntryKey,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Balance: Rs. ${calculatedMonthData.totalValue}",
                                        style: TextStyle(
                                          color: () {
                                            if (calculatedMonthData.totalValue >
                                                0) {
                                              return Colors.green;
                                            } else {
                                              return Colors.red;
                                            }
                                          }(),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }(),
                              () {
                                final groupByDay =
                                    // Value is List<TransactionModelIsar> per month
                                    groupBy(monthEntryValue, (obj) {
                                  final objectDateTime =
                                      DateTime.parse(obj.dateTime).formatDay();
                                  return objectDateTime;
                                });
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (final dayEntry in groupByDay.entries)
                                      Column(
                                        children: [
                                          () {
                                            final calculatedDayData =
                                                calculateTotalValue(
                                              dayEntry.value,
                                            );
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 17,
                                                    right: 17,
                                                    top: 4,
                                                    bottom: 4,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      () {
                                                        if (dayEntry.key ==
                                                            DateTime.now()
                                                                .formatDay()
                                                                .toString()) {
                                                          return const Text(
                                                            'Today',
                                                          );
                                                        } else {
                                                          // Key is day here
                                                          return Text(
                                                            dayEntry.key,
                                                          );
                                                        }
                                                      }(),
                                                      const Spacer(),
                                                      Text(
                                                        "Total: ${calculatedDayData.totalValue}",
                                                        style: TextStyle(
                                                          color: () {
                                                            if (calculatedDayData
                                                                    .totalValue >
                                                                0) {
                                                              return Colors
                                                                  .green;
                                                            } else {
                                                              return Colors.red;
                                                            }
                                                          }(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Value is TransactionModelIsar list item
                                                for (final listItem
                                                    in dayEntry.value)
                                                  Column(
                                                    children: [
                                                      TransactionView(
                                                        transaction: listItem,
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            );
                                          }(),
                                        ],
                                      ),
                                  ],
                                );
                              }(),
                              const Divider(
                                height: 5,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("No data"),
                );
              }
            },
          ),
        );
      },
    );
  }
}
