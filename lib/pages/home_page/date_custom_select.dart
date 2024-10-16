import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/global_variables/time_range_global_vars.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/pages/page_functions/date_formatter.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_category_items.dart';

class CustomDateDialog extends StatefulWidget {
  final ValueNotifier<bool> bottomOpen;
  const CustomDateDialog({
    Key? key,
    required this.bottomOpen,
  }) : super(key: key);

  @override
  State<CustomDateDialog> createState() => _CustomDateDialogState();
}

class _CustomDateDialogState extends State<CustomDateDialog> {
  DateTime? selectedDateForStart;
  DateTime? selectedDateForEnd;

  TransactionsBloc get transactionsBloc => context.read<TransactionsBloc>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Set Custom Time Period",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // start date
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final currentDay = DateTime.now();
                          // final nextDay = DateTime(currentDay.year, currentDay.month, currentDay.day);
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TableCalendar(
                                  firstDay: DateTime.utc(2010, 01, 01),
                                  lastDay: selectedDateForEnd ?? currentDay,
                                  availableCalendarFormats: const {
                                    CalendarFormat.month: 'Month',
                                  },
                                  focusedDay: () {
                                    if (selectedDateForStart != null) {
                                      return selectedDateForStart;
                                    } else if (selectedDateForStart == null &&
                                        selectedDateForEnd != null) {
                                      return selectedDateForEnd;
                                    } else {
                                      return DateTime.now();
                                    }
                                  }() as DateTime,
                                  // selectedDateForStart ?? DateTime.now(),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      selectedDateForStart = selectedDay;
                                    });
                                    context.pop();
                                  },
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDateForStart, day);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: PopupCategoryItems(
                      title: () {
                        if (selectedDateForStart == null) {
                          return "Start Date     ";
                        } else {
                          return "${selectedDateForStart?.formatDayShort()}   ";
                        }
                      }(),
                    ),
                  ),
                  const Text(" - "),
                  // For end date
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TableCalendar(
                                  firstDay: selectedDateForStart ??
                                      DateTime.utc(2010, 01, 01),
                                  lastDay: DateTime.now(),
                                  availableCalendarFormats: const {
                                    CalendarFormat.month: 'Month',
                                  },
                                  // Issues may happen here
                                  focusedDay:
                                      selectedDateForEnd ?? DateTime.now(),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      final currentDate = selectedDay;
                                      selectedDateForEnd = currentDate;
                                    });
                                    context.pop();
                                  },
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDateForEnd, day);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: PopupCategoryItems(
                      title: () {
                        if (selectedDateForEnd == null) {
                          return "End Date     ";
                        } else {
                          return "${selectedDateForEnd?.formatDayShort()}   ";
                        }
                      }(),
                    ),
                  ),
                ],
              ),
            ),
            // Cancel and Save
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      if (selectedDateForStart != null &&
                          selectedDateForEnd != null) {
                        // Added one day more to get proper range
                        final selectedDayEndPlusOne = DateTime(
                            selectedDateForEnd!.year,
                            selectedDateForEnd!.month,
                            selectedDateForEnd!.day + 1);

                        context.read<TimeRangeCubit>().timeRangeState(
                              selectedDateForStart.toString(),
                              selectedDayEndPlusOne.toString(),
                              customTimeRange,
                            );

                        transactionsBloc.add(
                          TransactionsLoadedEvent(
                            timeRangeState: TimeRangeState(
                              buttonName: customTimeRange,
                              startTime: selectedDateForStart.toString(),
                              endTime: selectedDayEndPlusOne.toString(),
                            ),
                          ),
                        );
                        widget.bottomOpen.value = false;
                        context.pop();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
