import 'package:equatable/equatable.dart';
import 'package:talent_on_screen_v2/repositry/model/talent_model.dart';

abstract class TalentEvent extends Equatable {
  const TalentEvent();
}

class TalentLoadingEvent extends TalentEvent {
  @override
  List<Object?> get props => [];
}

class TalentLoadedEvent extends TalentEvent {
  final int weekId;
  const TalentLoadedEvent({required this.weekId});
  List<Object?> get props => [weekId];
}

class TalentShareDoneEvent extends TalentEvent {
  final TalentModel talent;
  final int talentId;
  final int weekId;
  const TalentShareDoneEvent(
      {required this.talentId, required this.weekId, required this.talent});
  List<Object?> get props => [talentId, weekId, talent];
}
