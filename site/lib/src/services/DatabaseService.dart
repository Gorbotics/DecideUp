import 'dart:async';

import 'package:decideup/src/firebase/DecideFire.dart';

class DatabaseService {
  final DecideFire fire = DecideFire();
  DatabaseService();

  Future<void> push(String path, dynamic obj) {
    return fire.push(path, obj);
  }

  Future<void> save(String path, dynamic obj) {
    return fire.save(path, obj);
  }

  Future<dynamic> get(String path) {
    return fire.get(path);
  }
}