import 'package:backend/backend.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final IActivityService _activityService;
  final String userId;
  List<Activity> activities = [];

  ActivityBloc(this._activityService, this.userId) : super(ActivityInitial()) {
    on<ActivityLoad>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      activities = await _activityService.getActivities(userId);
      emit(ActivityLoadSuccess());
    });
  }
}
