part of 'quick_click_cubit.dart';

@immutable
sealed class QuickClickState {
  final bool isDisplay;
  final DateTime? startTime;
  final DateTime? endTime;
  final double? reactionTime;
  final List<double>? reactionTimeList;
  const QuickClickState(
      {this.reactionTimeList,
      this.reactionTime,
      this.startTime,
      this.endTime,
      required this.isDisplay});
}

//初始化
final class QuickClickInitial extends QuickClickState {
  const QuickClickInitial(
      {super.reactionTimeList,
      super.reactionTime,
      super.startTime,
      super.endTime,
      required super.isDisplay});
}

//开始计时
final class QuickClickRunning extends QuickClickState {
  const QuickClickRunning(
      {super.reactionTimeList,
      super.reactionTime,
      super.startTime,
      super.endTime,
      required super.isDisplay});
}

//显示图片
final class QuickClickDisplay extends QuickClickState {
  const QuickClickDisplay(
      {super.reactionTimeList,
      super.reactionTime,
      super.startTime,
      super.endTime,
      required super.isDisplay});
}

//结束计时
final class QuickClickComplete extends QuickClickState {
  const QuickClickComplete(
      {super.reactionTimeList,
      super.reactionTime,
      super.startTime,
      super.endTime,
      required super.isDisplay});
}
