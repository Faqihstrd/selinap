import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class UserLocal {
  final _box = GetStorage();
  final _key = "banfka_login";

  bool get isLogin => _box.hasData(_key);

  Future<void> saveData(Map<String, dynamic> user) async {
    print("user");
    await _box.write(_key, jsonEncode(user));
  }

  Map<String, dynamic>? getUser() =>
      isLogin ? json.decode(_box.read(_key)) : null;
  Future<void> logOut() => _box.remove(_key);
}
