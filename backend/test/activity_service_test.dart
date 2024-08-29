import 'package:backend/services/activity_service.dart';
import 'package:backend/services/user_service.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import 'package:flutter_test/flutter_test.dart';

/// Ensure these tests are run in a _**SEPARATE**_ container from the app instance of RethinkDB
void main() {
  RethinkDb r = RethinkDb();
  late Connection conn;
  late UserService userService;
  late ActivityService sut;
  late String userId;

  setUp(() async {
    conn = await r.connect(host: '127.0.0.1', port: 28015);

    await r.tableCreate('users').run(conn).catchError((_) => {});
    await r.table('users').indexCreate('email').run(conn);
    await r.table('users').indexWait('email').run(conn);
    await r.tableCreate('activities').run(conn).catchError((_) => {});

    userService = UserService(r, conn);

    final result = await userService.create('test@test.me', 'test1234');
    userId = result.value!.id!;

    sut = ActivityService(r, conn);
  });

  tearDown(() async {
    await r.tableDrop('users').run(conn).catchError((_) => {});
    await r.tableDrop('activities').run(conn).catchError((_) => {});
  });

  test('successfully creates a new activity', () async {
    final result = await sut.create(userId, 'Mathematics', 'Extension 2');
    expect(result.value!.name, 'Mathematics');
    expect(result.value!.description, 'Extension 2');
    expect(result.error, null);
  });

  test('rejects creation of an existing activity', () async {
    await sut.create(userId, 'Mathematics', 'Extension 2');
    final result = await sut.create(userId, 'Mathematics', 'Extension 2');
    expect(result.value, null);
    expect(result.error, isA<String>());
  });

  test('assert that activities are ordered correctly, including post-deletion', () async {
    final activityData = [
      ('Mathematics', 'Extension 2'),
      ('Coding', 'Work'),
      ('English', ' '),
      ('Music', 'Performance')
    ];

    String? codingId;

    for (var pair in activityData) {
      final result = await sut.create(userId, pair.$1, pair.$2);
      if (pair.$1 == 'Coding') {
        codingId = result.value!.id!;
      }
    }

    // Simulate deleting and re-creating the Coding activity
    await sut.delete(codingId!);
    await sut.create(userId, 'Coding', 'Work on Zonin');

    final activities = await sut.getActivities(userId);

    final expectedActivityData = [
      (0, 'Mathematics', 'Extension 2'),
      (2, 'English', ' '),
      (3, 'Music', 'Performance'),
      (4, 'Coding', 'Work on Zonin'),
    ];

    for (var i = 0; i < activities.length; i++) {
      expect(
        (activities[i].order, activities[i].name, activities[i].description),
        expectedActivityData[i],
      );
    }
  });
}
