part of 'quick_click_cubit.dart';

enum QuickClickStatus { initial, running, display, complete }

@immutable
final class QuickClickState extends Equatable {
  final QuickClickStatus status;
  final bool isDisplay;
  final DateTime? startTime;
  final DateTime? endTime;
  final double? reactionTime;
  final List<double>? reactionTimeList;

  const QuickClickState(
      {this.status = QuickClickStatus.initial,
      this.reactionTimeList,
      this.reactionTime,
      this.startTime,
      this.endTime,
      this.isDisplay = false});

  QuickClickState copyWith({
    QuickClickStatus? status,
    bool? isDisplay,
    DateTime? startTime,
    DateTime? endTime,
    double? reactionTime,
    List<double>? Function()? reactionTimeList,
  }) {
    return QuickClickState(
        status: status ?? this.status,
        isDisplay: isDisplay ?? this.isDisplay,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        reactionTime: reactionTime ?? this.reactionTime,
        reactionTimeList: reactionTimeList != null
            ? reactionTimeList()
            : this.reactionTimeList);
  }

  @override
  List<Object?> get props =>
      [isDisplay, startTime, endTime, reactionTime, reactionTimeList, status];
}
