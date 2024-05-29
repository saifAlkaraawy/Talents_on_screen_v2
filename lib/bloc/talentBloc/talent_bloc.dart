import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_on_screen_v2/bloc/talentBloc/talent_event.dart';
import 'package:talent_on_screen_v2/bloc/talentBloc/talent_state.dart';
import 'package:talent_on_screen_v2/repositry/data.dart';
import 'package:talent_on_screen_v2/repositry/model/talent_model.dart';

class TalentBloc extends Bloc<TalentEvent, TalentState> {
  Data _data;

  TalentBloc(this._data) : super(TalentLoadingState()) {
    on<TalentLoadedEvent>((event, emit) async {
      emit(TalentLoadingState());
      try {
        List talents = await _data.getTalentData(event.weekId);

        talents.sort((a, b) =>
            a["talents_info"]['count'].compareTo(b["talents_info"]['count']));

        List<TalentModel> List_talents = talents
            .map(
              (e) => TalentModel(
                id: e["talents_info"]["id"],
                name: e["talents_info"]["name"],
                age: e["talents_info"]["age"],
                image_URL: e["talents_info"]["image_URL"],
                count: e["talents_info"]["count"],
                job: e["talents_info"]["job"],
                share_name: e["talents_info"]["share_name"],
                isFavorite: e["talents_info"]["is_favorite"],
              ),
            )
            .toList();

        emit(TalentLoadedState(talents: List_talents));
      } catch (e) {
        emit(TalentErrorState(error: e.toString()));
      }
    });

    on<TalentShareDoneEvent>((event, emit) async {
      try {
        await _data.increaseTalentCountByOne(id: event.talentId);
        await _data.TalentDone(id: event.talentId, weekId: event.weekId);

        emit(talentShareDoneState(talent: event.talent));
        emit(NewState());
      } catch (e) {
        emit(TalentErrorState(error: e.toString()));
      }
    });
  }
}
