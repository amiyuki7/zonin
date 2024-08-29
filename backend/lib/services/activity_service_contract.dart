import 'package:backend/models/activity.dart';

abstract class IActivityService {
  /// Attempts to create a new Activity.
  /// Returns a `Activity` instance with a populated `_id` field if the creation is successful.
  Future<ActivityResult<Activity, String>> create(String userId, String name, String? description);

  /// Deletes an activity
  Future<void> delete(String activityId);

  /// Returns all activities associated with a [userId] in ascending order of creation.
  Future<List<Activity>> getActivities(String userId);
}

final class ActivityResult<T, E> {
  T? value;
  E? error;

  ActivityResult.ok(T this.value);
  ActivityResult.err(E this.error);
}
