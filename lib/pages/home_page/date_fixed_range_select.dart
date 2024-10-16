import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';

class DateSelectButton extends StatelessWidget {
  const DateSelectButton({
    Key? key,
    required this.bottomOpen,
    required this.buttonText,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  final ValueNotifier<bool> bottomOpen;
  final String buttonText;
  final String? startTime;
  final String? endTime;

  @override
  Widget build(BuildContext context) {
    final TransactionsBloc transactionsBloc = context.read<TransactionsBloc>();
    final String titleText = context.read<TimeRangeCubit>().state.buttonName;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: () {
          if (titleText == buttonText) {
            return Colors.blue;
          } else {
            return Colors.transparent;
          }
        }(),
      ),
      onPressed: () {
        //
        transactionsBloc.add(
          TransactionsLoadedEvent(
            timeRangeState: TimeRangeState(buttonName: buttonText),
          ),
        );
        //
        bottomOpen.value = false;
        // save new state
        context.read<TimeRangeCubit>().timeRangeState(
              startTime,
              endTime,
              buttonText,
            );
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}