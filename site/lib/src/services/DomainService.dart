import 'dart:async';
import 'package:decideup/src/domain/Entity.dart';
import 'package:decideup/src/services/GroupService.dart';
import 'package:decideup/src/services/TopicService.dart';
import 'package:decideup/src/services/UserService.dart';


abstract class DomainService<T extends Entity> {
  Future<T> getBy(String uid);

  Future<T> save(T entity);

  Future<List<T>> getAll(Iterable<String> uids) async {
    List<T> list = List();

    for(String uid in uids) {
      list.add(await getBy(uid));
    }
    return list;
  }
}

class DatabaseService {
  final UserService user = UserService();
  final GroupService group = GroupService();
  final TopicService topic = TopicService();

  DatabaseService() {
    user.databaseService = this;
    group.databaseService = this;
    topic.databaseService = this;
  }
}