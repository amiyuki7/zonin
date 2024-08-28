import 'dart:convert';

import 'package:backend/models/user.dart';
import 'package:backend/services/user_service_contract.dart';
import 'package:crypto/crypto.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

class UserService implements IUserService {
  final RethinkDb _r;
  final Connection _conn;

  UserService(this._r, this._conn);

  @override
  Future<UserResult<User, String>> login(String email, String password) async {
    final cursor = await _r.table('users').getAll(email, {'index': 'email'}).run(_conn);

    final List<dynamic> userList = await cursor.toList();

    // Email doesn't exist
    if (userList.isEmpty) return UserResult.err('Invalid email or password');

    if (userList.first['password'] == _toHash(password)) {
      return UserResult.ok(User.fromDocument({
        'email': userList.first['email'],
        'id': userList.first['id'],
      }));
    }

    // Email exists, but incorrect password
    return UserResult.err('Invalid email or password');
  }

  @override
  Future<UserResult<User, String>> create(String email, String password) async {
    // Check the email has not already used
    final existing = await _r.table('users').getAll(email, {'index': 'email'}).count().run(_conn);

    if (existing > 0) return UserResult.err('Email $email is already in use');

    // An insert conflict should never happen
    final result = await _r.table('users').insert(
      {'email': email, 'password': _toHash(password)},
      {'return_changes': true},
    ).run(_conn);

    return UserResult.ok(
      User.fromDocument(result['changes'].first['new_val']),
    );
  }

  String _toHash(String text) {
    List<int> bytes = utf8.encode(text);
    return sha256.convert(bytes).toString();
  }
}
