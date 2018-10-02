import 'dart:async';

import 'package:decideup/src/domain/Entity.dart';
import 'package:decideup/src/domain/Topic.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/services/DomainService.dart';

class Group implements Entity {
  String name;
  String description;

  String uid;
  Map<String, String> userToInfo = Map();
  Map<String, int> topicToCreateTime = Map();
  DatabaseService service;

  Group(this.name, this.description, {this.uid, this.userToInfo, this.topicToCreateTime, this.service});

  Future<List<User>> members() {
    return service.user.getAll(userToInfo.keys);
  }

  Future<List<Topic>> topics() {
    return service.topic.getAll(topicToCreateTime.keys);
  }
}
