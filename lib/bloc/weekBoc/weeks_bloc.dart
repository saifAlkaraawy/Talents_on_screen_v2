import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_on_screen_v2/bloc/weekBoc/weeks_event.dart';
import 'package:talent_on_screen_v2/bloc/weekBoc/weeks_state.dart';
import 'package:talent_on_screen_v2/repositry/data.dart';
import 'package:talent_on_screen_v2/repositry/model/week_model.dart';

class WeeksBloc extends Bloc<WeeksEvent, WeeksState> {
  Data _data;

  WeeksBloc(this._data) : super(WeekLoadingState()) {
    on<WeekLoadEvent>((event, emit) async {
      emit(WeekLoadingState());

      try {
        List data = await _data.getWeekData();

        print(data);
        print("loaded");

        List<WeekModel> weeks = await data
            .map((e) =>
                WeekModel(id: e["id"], name: e["name"], date: e["created_at"]))
            .toList();

        emit(WeekLoadedState(weeks: weeks));
      } catch (e) {
        emit(WeekErorrState(error: e.toString()));
      }
    });
  }
}
