part of 'activity_bloc.dart';

sealed class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

final class ActivityLoad extends ActivityEvent {}

final class ActivityCreate extends ActivityEvent {
  final String name;
  final String description;

  const ActivityCreate(this.name, this.description);

  @override
  List<Object> get props => [name, description];
}
