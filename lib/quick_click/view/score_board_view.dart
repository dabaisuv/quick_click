import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../quick_click.dart';

class ScoreBoardView extends StatelessWidget {
  const ScoreBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var state = context.watch<QuickClickCubit>().state;
      return state.reactionTimeList != null
          ? Column(children: [
              Text(
                  '平均成绩:${(state.reactionTimeList!.reduce((value, element) => value + element) / state.reactionTimeList!.length).toStringAsFixed(3)}毫秒',
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 127, 36, 29))),
              ...state.reactionTimeList!
                  .asMap()
                  .map((k, e) => MapEntry(
                      k,
                      Text(
                        '第${k + 1}次成绩：$e毫秒！',
                        style: const TextStyle(fontSize: 30),
                      )))
                  .values
                  .toList()
                  .reversed
                  .toList()
            ])
          : const Text('暂无成绩，请点击开始', style: TextStyle(fontSize: 25));
    });
  }
}
