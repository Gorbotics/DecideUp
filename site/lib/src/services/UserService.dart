import 'dart:async';
import 'package:decideup/src/domain/LoginResult.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/firebase/DecideFire.dart';
import 'package:decideup/src/services/DomainService.dart';
import 'package:js/js_util.dart' as util;

class UserService extends DomainService<User> {
  DatabaseService databaseService;
  DecideFire fire = DecideFire();

  Future<User> current() async {
    return _convert(await fire.currentUser());
  }

  @override
  Future<User> getBy(String uid) async {
    final dynamic userObject = await fire.get("users/" + uid);
    return User(userObject.uid, userObject.name);
  }

  @override
  Future<User> save(User user) async {
    var object = util.newObject();
    util.setProperty(object, "name", user.name);

    var groups = util.newObject();
    user.groupToInfo.forEach((uid, info) => util.setProperty(groups, uid, info));

    util.setProperty(object, "groups", groups);

    await fire.save("users/" + user.uid, object);

    return user;
  }

  User _convert(dynamic data) {
    if(data == null) {
      return null;
    }
    final dynamic groups = util.getProperty(data, "groups");

    final Map<String, String> groupToInfo = Map();
    for(var uid in fire.getKeysForObject(groups)) {
      groupToInfo[uid] = util.getProperty(groups, uid);
    }
    return User(data.uid, data.name, groupToInfo: groupToInfo, service: databaseService);
  }

  Future<LoginResult> login(email, password) async {
    final FireLoginResult result = await fire.login(email, password);
    if(result.user != null) {
      return LoginResult(_convert(result.user), null);
    } else {
      return LoginResult(null, result.error);
    }
  }

  Future<LoginResult> signup(email, password, displayName) async {
    final FireLoginResult result = await fire.signup(email, password, displayName);
    if(result.user != null) {
      return LoginResult(_convert(result.user), null);
    } else {
      return LoginResult(null, result.error);
    }
  }

  Future<void> logout() async {
    fire.logout();
  }
}
