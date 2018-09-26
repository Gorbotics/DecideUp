import 'dart:js';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/navigation/route_paths.dart';
import 'package:decideup/src/services/UserService.dart';

@Component(
  selector: 'dashboard',
  templateUrl: 'dashboard.html',
  directives: [coreDirectives, formDirectives],
  styleUrls: ['dashboard.css'],
)
class Dashboard implements OnActivate {
  UserService userService;
  Router router;

  String displayName;

  Dashboard(this.userService, this.router);

  @override
  void onActivate(RouterState previous, RouterState current) {
    context.callMethod("initMaterialize");
    this.userService.current().then((user) {
      if(user != null) {
        displayName = user.name();
      } else {
        router.navigate(RoutePaths.login.toUrl());
      }
    });
  }

  void addGroup() {
    router.navigate(RoutePaths.addGroup.toUrl());
  }
}