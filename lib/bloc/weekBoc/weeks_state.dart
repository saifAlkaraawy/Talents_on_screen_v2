import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:talent_on_screen_v2/repositry/model/week_model.dart';

@immutable
abstract class WeeksState extends Equatable {
  const WeeksState();
}

class WeekLoadingState extends WeeksState {
  @override
  List<Object?> get props => [];
}

class WeekLoadedState extends WeeksState {
  final List<WeekModel> weeks;
  const WeekLoadedState({required this.weeks});
  @override
  List<Object?> get props => [weeks];
}

class WeekErorrState extends WeeksState {
  final String error;
  const WeekErorrState({required this.error});
  @override
  List<Object?> get props => [error];
}

class weekAddedSeccussfuly extends WeeksState {
  @override
  List<Object?> get props => [];
}
