import 'package:backend/models/activity.dart';
import 'package:backend/services/activity_service_contract.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

class ActivityService implements IActivityService {
  final RethinkDb _r;
  final Connection _conn;

  ActivityService(this._r, this._conn);

  @override
  Future<ActivityResult<Activity, String>> create(
    String userId,
    String name,
    String? description,
  ) async {
    final existing = await getActivities(userId);

    if (existing.any((activity) => activity.name == name && activity.description == description)) {
      return ActivityResult.err('Fail: already exists');
    }

    // Keep track of creation order
    int order = (existing.isEmpty) ? 0 : existing.last.order + 1;

    final result = await _r.table('activities').insert(
      {
        'userId': userId,
        'name': name,
        'description': description,
        'style': ' ',
        'order': order,
      },
      {'return_changes': true},
    ).run(_conn);

    return ActivityResult.ok(
      Activity.fromDocument(result['changes'].first['new_val']),
    );
  }

  @override
  Future<void> delete(String activityId) async {
    await _r.table('activities').get(activityId).delete().run(_conn);
  }

  @override
  Future<List<Activity>> getActivities(String userId) async {
    final cursor = await _r //
        .table('activities')
        .filter({'userId': userId})
        .orderBy(_r.asc('order'))
        .run(_conn);

    List<dynamic> result = await cursor.toList();
    return result.map((doc) => Activity.fromDocument(doc)).toList();
  }
}
