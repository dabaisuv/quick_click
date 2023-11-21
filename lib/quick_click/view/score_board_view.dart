import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../quick_click.dart';

class ScoreBoardView extends StatelessWidget {
  const ScoreBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var state = context.watch<QuickClickCubit>().state;
      return state is QuickClickComplete
          ? Text(
              '成绩：${state.reactionTime}毫秒！',
              style: TextStyle(fontSize: 30),
            )
          : Container();
    });
  }
}
