import 'package:equatable/equatable.dart';
import 'package:flutter_expense_tracker/global_variables/time_range_global_vars.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_range_state.dart';
part 'time_range_cubit.g.dart';

class TimeRangeCubit extends HydratedCubit<TimeRangeState> {
  TimeRangeCubit() : super(const TimeRangeState());

  void timeRangeState(String? startTime, String? endTime, String buttonName) {
    emit(state.copyWith(
      startTime: startTime,
      endTime: endTime,
      buttonName: buttonName,
    ));
  }

  @override
  TimeRangeState? fromJson(Map<String, dynamic> json) {
    return TimeRangeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TimeRangeState state) {
    return state.toJson();
  }
}
