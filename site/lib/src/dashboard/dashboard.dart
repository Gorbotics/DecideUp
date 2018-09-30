import 'dart:js';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/RootService.dart';
import 'package:decideup/src/common/Loading.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/navigation/route_paths.dart';
import 'package:decideup/src/services/GroupService.dart';
import 'package:decideup/src/services/UserService.dart';


@Component(
  selector: 'dashboard',
  templateUrl: 'dashboard.html',
  directives: [coreDirectives, formDirectives],
  styleUrls: ['dashboard.css'],
)
class Dashboard implements OnActivate {
  RootService rootService;
  UserService userService;
  GroupService groupService;
  Router router;
  String displayName;

  List<Group> groups = List();

  Dashboard(this.rootService, this.userService, this.router, this.groupService) {
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    this.rootService.showLoading = true;
    this.userService.current().then((user) {
      if(user != null) {
        displayName = user.name();
        this.groupService.groupsFor(user).then((groups) {
          this.groups = groups;
          this.rootService.showLoading = false;
        });
      } else {
        this.rootService.showLoading = false;
        router.navigate(RoutePaths.login.toUrl());
      }
    });
  }

  void viewGroup(Group group) {
    router.navigate(RoutePaths.viewGroup.toUrl(parameters: {'uid': group.uid}));
  }

  void addGroup() {
    router.navigate(RoutePaths.addGroup.toUrl());
  }
}