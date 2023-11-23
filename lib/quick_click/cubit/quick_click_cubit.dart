import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'quick_click_state.dart';

class QuickClickCubit extends Cubit<QuickClickState> {
  QuickClickCubit() : super(const QuickClickState());

  StreamSubscription? displaySubscription;
  //开始计时
  void start() {
    //开始执行计时逻辑

    emit(state.copyWith(status: QuickClickStatus.running));
    var random = Random();

    var displayAfter = Duration(
        seconds: random.nextInt(2), milliseconds: random.nextInt(500) + 500);
    var startTime = DateTime.now().add(displayAfter);

    displaySubscription =
        Future.delayed(displayAfter).asStream().listen((event) {
      emit(
          //计时完成，显示图片
          state.copyWith(
        status: QuickClickStatus.complete,
        startTime: startTime,
        isDisplay: true,
      ));
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
      emit(state.copyWith(
        status: QuickClickStatus.initial,
        isDisplay: false,
      ));
      return;
    }
    if (startTime != null) {
      var reactionTime = endTime.difference(startTime);
      List<double> reactionTimeList = state.reactionTimeList ?? [];

      reactionTimeList.add(reactionTime.inMilliseconds.toDouble());

      emit(
        state.copyWith(
            status: QuickClickStatus.complete,
            isDisplay: false,
            endTime: endTime,
            reactionTime: reactionTime.inMilliseconds.toDouble(),
            reactionTimeList: () => reactionTimeList),
      );
      print(reactionTime);
    }
  }

  //清除历史成绩
  void clear() {
    emit(
      state.copyWith(
          status: QuickClickStatus.complete, reactionTimeList: () => null),
    );
  }
}
