import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quick_click_state.dart';

class QuickClickCubit extends Cubit<QuickClickState> {
  QuickClickCubit() : super(const QuickClickInitial(isDisplay: false));

  StreamSubscription? displaySubscription;
  //开始计时
  void start() {
    //开始执行计时逻辑
    emit(QuickClickRunning(
        isDisplay: state.isDisplay, reactionTimeList: state.reactionTimeList));
    var random = Random();

    var displayAfter = Duration(
        seconds: random.nextInt(2), milliseconds: random.nextInt(980) + 20);
    var startTime = DateTime.now().add(displayAfter);

    displaySubscription =
        Future.delayed(displayAfter).asStream().listen((event) {
      emit(
          //计时完成，显示图片
          QuickClickDisplay(
              startTime: startTime,
              isDisplay: !state.isDisplay,
              reactionTimeList: state.reactionTimeList));
    });
  }

  //结束计时
  void end() {
    var endTime = DateTime.now();
    var startTime = state.startTime;
    if (state.isDisplay == false) {
      //还没出现图片就点了
      print('还没出现图片就点了');
      displaySubscription?.cancel();
      emit(QuickClickInitial(
          isDisplay: false, reactionTimeList: state.reactionTimeList));
      return;
    }
    if (startTime != null) {
      var reactionTime = endTime.difference(startTime);
      List<double> reactionTimeList = state.reactionTimeList ?? [];

      reactionTimeList.add(reactionTime.inMilliseconds.toDouble());

      emit(
        QuickClickComplete(
            isDisplay: !state.isDisplay,
            endTime: endTime,
            startTime: state.startTime,
            reactionTime: reactionTime.inMilliseconds.toDouble(),
            reactionTimeList: reactionTimeList),
      );
      print(reactionTime);
    }
  }

  //清除历史成绩
  void clear() {
    emit(
      QuickClickComplete(
          isDisplay: state.isDisplay,
          endTime: state.endTime,
          startTime: state.startTime,
          reactionTime: state.reactionTime,
          reactionTimeList: null),
    );
  }
}
