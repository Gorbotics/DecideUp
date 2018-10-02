import 'dart:async';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/Topic.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/firebase/DecideFire.dart';
import 'package:decideup/src/services/DomainService.dart';
import 'package:js/js_util.dart' as util;

class TopicService extends DomainService<Topic> {
  DatabaseService databaseService;
  DecideFire fire = DecideFire();

  @override
  Future<Topic> getBy(String uid) async {
    final dynamic topicObject = await fire.get("topics/" + uid);
    final Group group = await databaseService.group.getBy(topicObject.group);
    final User creator = await databaseService.user.getBy(topicObject.creator);
    return Topic(topicObject.name, topicObject.description, group, creator);
  }

  @override
  Future<Topic> save(Topic topic) async {
    var object = util.newObject();
    util.setProperty(object, "name", topic.name);
    util.setProperty(object, "description", topic.description);

    util.setProperty(object, "creator", topic.creator.uid);
    util.setProperty(object, "group", topic.group.uid);

    final usersObject = util.newObject();
    for(var useruid in topic.group.userToInfo.keys) {
      util.setProperty(usersObject, useruid, "unread");
    }
    util.setProperty(object, "users", usersObject);

    if(topic.uid == null) {
      String uid = await fire.push("topics", object);
      topic = Topic(topic.name, topic.description, topic.group, topic.creator, uid: uid, service: databaseService);
    } else {
      await fire.save("topics/" + topic.uid, object);
    }

    return topic;
  }
}
