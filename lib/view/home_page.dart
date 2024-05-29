import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talent_on_screen_v2/bloc/weekBoc/weeks_bloc.dart';
import 'package:talent_on_screen_v2/bloc/weekBoc/weeks_event.dart';
import 'package:talent_on_screen_v2/bloc/weekBoc/weeks_state.dart';
import 'package:talent_on_screen_v2/constant/color.dart';
import 'package:talent_on_screen_v2/view/talents_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  String formatingDate(var weekDate) {
    DateTime weekDateLocal = DateTime.parse(weekDate).toLocal();
    String formattedDate = DateFormat('yyyy-MM-dd').format(weekDateLocal);
    return formattedDate;
  }

  final _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الموهوب الصغير",
          style: TextStyle(color: Color(0xFFFFC502)),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<WeeksBloc, WeeksState>(
        builder: (context, state) {
          if (state is WeekLoadingState) {
            context.read<WeeksBloc>().add(WeekLoadEvent());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WeekErorrState) {
            return Center(child: Text(" this . ${state.error}"));
          }

          if (state is WeekLoadedState) {
            return ListView.builder(
                itemCount: state.weeks.length,
                itemBuilder: (context, index) {
                  final name = state.weeks[index].name;
                  final weekDate = state.weeks[index].date;
                  final id = state.weeks[index].id;

                  String weekDateLocal = formatingDate(weekDate);

                  return Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    margin: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Talents(
                                      week_id: id,
                                    )));
                      },
                      child: Card(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0, bottom: 10.0, top: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$name",
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  weekDateLocal,
                                  style: const TextStyle(
                                      fontSize: 20.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }
}
