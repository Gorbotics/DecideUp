import 'dart:js';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/RootService.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/navigation/route_paths.dart';
import 'package:decideup/src/services/DomainService.dart';
import 'package:decideup/src/services/GroupService.dart';
import 'package:decideup/src/services/TopicService.dart';
import 'package:decideup/src/services/UserService.dart';

@Component(
  selector: 'viewGroup',
  templateUrl: 'viewGroup.html',
  directives: [coreDirectives, formDirectives],
  styleUrls: ['viewGroup.css'],
)
class ViewGroup implements OnActivate {
  RootService rootService;
  DatabaseService databaseService;
  Router router;

  User currentUser;

  Group group;

  ViewGroup(this.rootService, this.databaseService, this.router) {
    group = Group("", "");
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    rootService.showLoading = true;
    context.callMethod("initMaterialize");
    this.databaseService.user.current().then((user) {
      rootService.showLoading = false;
      if(user != null) {
        currentUser = user;
      } else {
        router.navigate(RoutePaths.login.toUrl());
      }
    });

    String uid = current.parameters["uid"];
    this.databaseService.group.getBy(uid).then((group) {
      this.group = group;
    });
  }

  void addTopic() {
    router.navigate(RoutePaths.addTopic.toUrl());
  }

  void viewMembers() {

  }

  void invite() {

  }
}