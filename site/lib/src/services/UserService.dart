import 'dart:async';

import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/firebase/DecideFire.dart';

class UserService {
  final DecideFire fire = DecideFire();
  UserService();

  Future<User> current() async {
    return await fire.currentUser();
  }

  void logout() {
    fire.logout();
  }
}