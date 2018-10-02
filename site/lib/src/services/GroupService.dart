import 'dart:async';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/firebase/DecideFire.dart';
import 'package:decideup/src/services/DomainService.dart';
import 'package:js/js_util.dart' as util;


class GroupService extends DomainService<Group> {
  DatabaseService databaseService;
  DecideFire fire = DecideFire();

  @override
  Future<Group> getBy(String uid) async {
    final dynamic groupObject = await fire.get("groups/" + uid);
    return Group(groupObject.name, groupObject.description, uid: uid);
  }

  @override
  Future<Group> save(Group group) async {
    var object = util.newObject();
    util.setProperty(object, "name", group.name);
    util.setProperty(object, "description", group.description);

    final User currentUser = await databaseService.user.current();
    var usersObject = util.newObject();
    util.setProperty(usersObject, currentUser.uid, "owner");

    util.setProperty(object, "users", usersObject);

    var topics = util.newObject();
    util.setProperty(object, "topics", topics);

    if(group.uid == null) {
      String uid = await fire.push("groups", object);
      group = Group(group.name, group.description, uid: uid, userToInfo: {uid: "owner"}, topicToCreateTime: {}, service: databaseService);
    } else {
      await fire.save("groups/" + group.uid, object);
    }

    return group;
  }
}
