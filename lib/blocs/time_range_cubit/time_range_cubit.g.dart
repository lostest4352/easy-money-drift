// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_range_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeRangeState _$TimeRangeStateFromJson(Map<String, dynamic> json) =>
    TimeRangeState(
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      buttonName: json['buttonName'] as String? ?? thisMonth,
    );

Map<String, dynamic> _$TimeRangeStateToJson(TimeRangeState instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'buttonName': instance.buttonName,
    };
