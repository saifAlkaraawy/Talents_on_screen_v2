import 'package:equatable/equatable.dart';
import 'package:talent_on_screen_v2/repositry/model/talent_model.dart';

abstract class TalentState extends Equatable {
  const TalentState();
}

final class TalentLoadingState extends TalentState {
  @override
  List<Object?> get props => [];
}

final class talentShareDoneState extends TalentState {
  final TalentModel talent;

  const talentShareDoneState({required this.talent});
  @override
  List<Object?> get props => [talent];
}

// i'm create this class for just use it  to create new state after send talentShareDoneState
//because liatener in bloc can't response to same state if forced to change state and send talentShareDoneState second time.
final class NewState extends TalentState {
  @override
  List<Object?> get props => [];
}

class TalentLoadedState extends TalentState {
  List talents;
  TalentLoadedState({required this.talents});
  @override
  List<Object?> get props => [talents];
}

class TalentErrorState extends TalentState {
  final String error;
  const TalentErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
