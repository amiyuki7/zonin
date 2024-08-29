part of 'activity_bloc.dart';

sealed class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

final class ActivityInitial extends ActivityState {}

final class ActivityLoadSuccess extends ActivityState {}

final class ActivityCreateFail extends ActivityState {
  final String error;

  const ActivityCreateFail(this.error);

  @override
  List<Object> get props => [error];
}

final class ActivityCreateSuccess extends ActivityState {
  final Activity activity;

  const ActivityCreateSuccess(this.activity);

  @override
  List<Object> get props => [activity];
}
