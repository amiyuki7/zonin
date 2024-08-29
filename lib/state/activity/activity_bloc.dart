import 'package:backend/backend.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final IActivityService _activityService;
  final String userId;
  bool loaded = false;
  List<Activity> activities = [];

  ActivityBloc(this._activityService, this.userId) : super(ActivityInitial()) {
    on<ActivityLoad>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      activities = await _activityService.getActivities(userId);
      loaded = true;
      emit(ActivityLoadSuccess());
    });

    on<ActivityCreate>((event, emit) async {
      final result = await _activityService.create(userId, event.name, event.description);
      if (result.error != null) {
        // Creation error - that activity already exists!
        emit(ActivityCreateFail(result.error!));
      } else {
        emit(ActivityCreateSuccess(result.value!));
        activities.add(result.value!);
      }
      emit(ActivityInitial());
    });
  }
}
