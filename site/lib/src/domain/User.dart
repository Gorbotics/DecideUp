
import 'dart:async';

import 'package:decideup/src/domain/Entity.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/services/DomainService.dart';

class User implements Entity {
  String uid;
  String name;
  Map<String, String> groupToInfo = Map();

  DatabaseService service;

  User(this.uid, this.name, {this.groupToInfo, this.service});

  Future<List<Group>> groups() async {
    return await this.service.group.getAll(groupToInfo.keys);
  }

  Future<void> addGroup(final Group group) async {
    groupToInfo[group.uid] = "owner";
    service.user.save(this);
  }
}