import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_on_screen_v2/bloc/talentBloc/talent_bloc.dart';
import 'package:talent_on_screen_v2/bloc/talentBloc/talent_event.dart';
import 'package:talent_on_screen_v2/bloc/talentBloc/talent_state.dart';
import 'package:talent_on_screen_v2/constant/color.dart';
import 'package:talent_on_screen_v2/repositry/model/talent_model.dart';

class Talents extends StatefulWidget {
  final int week_id;
  const Talents({super.key, required this.week_id});
  @override
  State<Talents> createState() => _TalentsState();
}

class _TalentsState extends State<Talents> {
  @override
  void initState() {
    context.read<TalentBloc>().add(TalentLoadedEvent(weekId: widget.week_id));
    super.initState();
  }

  void showSuccessSnackbar(BuildContext context, TalentModel talent) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${talent.name}",
              style: TextStyle(color: Colors.amber),
            ),
            Text("   تم مشاركة الموهوب "),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TalentBloc, TalentState>(
        listenWhen: (previousState, currentState) =>
            (currentState is talentShareDoneState),
        buildWhen: (previous, current) =>
            !(current is talentShareDoneState || current is NewState),
        listener: (context, state) {
          print("state inside Listener $state");

          if (state is talentShareDoneState) {
            showSuccessSnackbar(context, state.talent);
          }
        },
        builder: (context, state) {
          if (state is TalentLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TalentErrorState) {
            return Center(
              child: Text("${state.error}"),
            );
          }

          if (state is TalentLoadedState) {
            if (state.talents.isEmpty) {
              return Stack(
                children: [
                  Image.asset(
                    "lib/assets/imges/background.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                  Center(
                    child: Text(
                      "لا توجد مواهب ",
                      style: TextStyle(color: Colors.white, fontSize: 80.0),
                    ),
                  )
                ],
              );
            }

            return PageView.builder(
              reverse: true,
              itemCount: state.talents.length,
              itemBuilder: (context, index) {
                TalentModel talent = state.talents[index];

                return Stack(
                  children: [
                    Image.asset(
                      "lib/assets/imges/background.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                    Row(
                      children: [
                        //icon go back
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image.asset(
                              "lib/assets/imges/go-to-work.png",
                              width: 60,
                              height: 60,
                            )),

                        //icon refresh
                        IconButton(
                            onPressed: () {
                              context.read<TalentBloc>().add(
                                  TalentLoadedEvent(weekId: widget.week_id));
                            },
                            icon: Image.asset(
                              "lib/assets/imges/refresh.png",
                              width: 60,
                              height: 60,
                            ))
                      ],
                    ),
                    Positioned(
                      right: 200,
                      child: Image.asset(
                        "lib/assets/imges/logo.png",
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 5,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      right: 200,
                      top: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "الاسم : ${talent.name}",
                            style: textStyle,
                          ),
                          Text(
                            "العمر : ${talent.age}",
                            style: textStyle,
                          ),
                          Text(
                            "المهنة : ${talent.job}",
                            style: textStyle,
                          ),
                          Text(
                            "نوع المشاركة : ${talent.share_name}",
                            style: textStyle,
                          ),
                          Text(
                            " عدد المشاركات  : ${talent.count}",
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height / 8,
                      left: MediaQuery.of(context).size.width / 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 300,
                        child: InkWell(
                          onTap: () {
                            context.read<TalentBloc>().add(TalentShareDoneEvent(
                                talentId: talent.id!,
                                weekId: widget.week_id,
                                talent: talent));

                            print("state inside Builder $state");
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 280,
                            backgroundImage:
                                NetworkImage('${talent.image_URL}'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        children: [
                          Text(
                            "${state.talents.length} /",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Text(
                            "${index + 1} ",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
