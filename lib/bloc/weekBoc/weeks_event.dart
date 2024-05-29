import 'package:equatable/equatable.dart';

abstract class WeeksEvent extends Equatable {
  const WeeksEvent();
}

class WeekLoadEvent extends WeeksEvent {
  @override
  List<Object?> get props => [];
}

class WeekDeleteEvent extends WeeksEvent {
  final int id;

  const WeekDeleteEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class WeekAddingEvent extends WeeksEvent {
  final String name;

  const WeekAddingEvent({required this.name});

  @override
  List<Object?> get props => [name];
}
