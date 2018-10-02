import 'dart:async';

import 'package:decideup/src/domain/Entity.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/services/DomainService.dart';

class Topic implements Entity {
  String uid;
  String name;
  String description;
  User creator;
  Group group;

  Map<String, String> userToReadStatus = Map();

  DatabaseService service;

  Topic(this.name, this.description, this.group, this.creator, {this.uid, this.userToReadStatus, this.service});

  Future<List<TopicUser>> users() async {
    List<TopicUser> topicUsers = List();

    List<User> users = await this.service.user.getAll(userToReadStatus.keys);

    for(User user in users) {
      topicUsers.add(TopicUser(user, userToReadStatus[user.uid]));
    }

    return topicUsers;
  }
}

class TopicUser {
  User user;
  String status;

  TopicUser(this.user, this.status);
}