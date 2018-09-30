import 'dart:async';

import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/LoginResult.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/firebase/DecideFire.dart';
import 'package:js/js_util.dart' as util;

class UserService {
  final DecideFire fire = DecideFire();

  User _current;

  UserService();


  Future<User> current() async {
    if(_current == null) {
      _current = await fire.currentUser();
    }

    return _current;
  }

  Future<void> addGroup(User user, Group group) async {
    final dynamic userObject = await fire.get("users/" + user.uid());

    dynamic groups;
    if(util.hasProperty(userObject, "groups")) {
      groups = util.getProperty(userObject, "groups");
    } else {
      groups = util.newObject();
      util.setProperty(userObject, "groups", groups);
    }
    util.setProperty(groups, group.uid, "owner");

    await fire.save("users/" + user.uid(), userObject);
  }

  Future<LoginResult> login(email, password) async {
    final LoginResult result = await this.fire.login(email, password);
    return result;
  }

  Future<LoginResult> signup(email, password, displayName) async {
    final LoginResult result = await this.fire.signup(email, password, displayName);
    return result;
  }

  void logout() {
    _current = null;
    fire.logout();
  }
}