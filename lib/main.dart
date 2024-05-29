import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talent_on_screen_v2/bloc/talentBloc/talent_bloc.dart';
import 'package:talent_on_screen_v2/bloc/weekBoc/weeks_bloc.dart';
import 'package:talent_on_screen_v2/constant/database_const.dart';

import 'package:talent_on_screen_v2/repositry/data.dart';
import 'package:talent_on_screen_v2/view/home_page.dart';
import 'package:talent_on_screen_v2/view/talents_page.dart';

void main() async {
  await Supabase.initialize(
    url: kprojectURL,
    anonKey: kApiKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeeksBloc(Data()),
        ),
        BlocProvider(
          create: (context) => TalentBloc(Data()),
        )
      ],
      child: MaterialApp(
          scrollBehavior: MyScrollBehavior(),
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: const Color(0xFF1b5352),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF1b5352),
            ),
          ),
          home: MyHomePage()),
    );
  }
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
