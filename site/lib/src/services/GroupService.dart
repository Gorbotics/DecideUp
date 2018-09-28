import 'dart:async';

import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/firebase/DecideFire.dart';
import 'package:decideup/src/services/UserService.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart' as util;

class GroupService {

  final DecideFire fire = DecideFire();
  final UserService userService;

  User currentUser;

  GroupService(this.userService) {
    this.userService.current().then((user) => this.currentUser = user);
  }

  Future<Group> group({String forUID}) async {
    final dynamic groupObject = await fire.get("groups/" + forUID);
    return Group(uid: forUID, name: groupObject.name, description: groupObject.description);
  }

  Future<List<Group>> groupsFor(User user) async {
    final dynamic userObject = await fire.get("users/" + user.uid());

    List<Group> groups = List();

    if(userObject.groups != null) {
      print("about to try to iterate over groups");
      List<String> uids = getKeysForObject(userObject.groups);
      for(var uid in uids) {
        groups.add(await group(forUID: uid));
      }
    }

    return groups;
  }

  Future<Group> save(Group group) async {
    var object = util.newObject();
    util.setProperty(object, "name", group.name);
    util.setProperty(object, "description", group.description);

    var usersObject = util.newObject();
    util.setProperty(usersObject, currentUser.uid(), "owner");

    util.setProperty(object, "users", usersObject);

    if(group.uid == null) {
      String uid = await this.fire.push("groups", object);
      group = Group(uid: uid, name: group.name, description: group.description);
      this.userService.addGroup(currentUser, group);
    } else {
      await this.fire.save("groups/" + group.uid, object);
    }

    return group;
  }
}