import 'package:backend/services/user_service.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import 'package:flutter_test/flutter_test.dart';

/// Ensure these tests are run in a _**SEPARATE**_ container from the app instance of RethinkDB
void main() {
  RethinkDb r = RethinkDb();
  late Connection conn;
  late UserService sut;

  setUp(() async {
    conn = await r.connect(host: '127.0.0.1', port: 28015);

    await r.tableCreate('users').run(conn).catchError((_) => {});
    await r.table('users').indexCreate('email').run(conn);
    await r.table('users').indexWait('email').run(conn);

    sut = UserService(r, conn);
  });

  tearDown(() async {
    await r.tableDrop('users').run(conn).catchError((_) => {});
  });

  test('successfully creates a user', () async {
    final result = await sut.create('amiyuki@zonin.dev', 'password1');
    expect(result.value!.email, 'amiyuki@zonin.dev');
    expect(result.error, null);
  });

  test('rejects the creation of an existing user', () async {
    await sut.create('amiyuki@zonin.dev', 'password1');
    final result = await sut.create('amiyuki@zonin.dev', 'password2');
    expect(result.value, null);
    expect(result.error, isA<String>());
  });

  test('successfully logs in as an existing user', () async {
    await sut.create('amiyuki@zonin.dev', 'password1');
    final result = await sut.login('amiyuki@zonin.dev', 'password1');
    expect(result.value!.email, 'amiyuki@zonin.dev');
    expect(result.error, null);
  });

  test('rejects logging in with a non existent email', () async {
    final result = await sut.login('amiyuki@zonin.dev', 'password1');
    expect(result.value, null);
    expect(result.error!, isA<String>());
  });

  test('rejects logging in with incorrect password', () async {
    await sut.create('amiyuki@zonin.dev', 'password1');
    final result = await sut.login('amiyuki@zonin.dev', 'this is the wrong password');
    expect(result.value, null);
    expect(result.error!, isA<String>());
  });
}
