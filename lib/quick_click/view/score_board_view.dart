import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../quick_click.dart';

class ScoreBoardView extends StatelessWidget {
  const ScoreBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<QuickClickCubit>().state;
    if (state.reactionTimeList != null) {
      return Column(children: [
        FittedBox(
          child: Text(
              '平均成绩:${(state.reactionTimeList!.reduce((value, element) => value + element) / state.reactionTimeList!.length).toStringAsFixed(3)}毫秒',
              style: const TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 127, 36, 29))),
        ),
        Expanded(
          child: ListView(
            children: state.reactionTimeList!
                .asMap()
                .map((k, e) => MapEntry(
                    k,
                    FittedBox(
                      child: Text(
                        '第${k + 1}次成绩：$e毫秒！',
                        style: const TextStyle(fontSize: 30),
                      ),
                    )))
                .values
                .toList()
                .reversed
                .toList(),
          ),
        )
      ]);
    } else {
      return const Align(
        alignment: Alignment.topCenter,
        child: FittedBox(
            child: Text('暂无成绩，请点击开始', style: TextStyle(fontSize: 25))),
      );
    }
  }
}
