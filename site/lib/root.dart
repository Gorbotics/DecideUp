import 'package:angular/angular.dart';
import 'package:decideup/RootService.dart';
import 'package:decideup/src/common/Loading.dart';
import 'package:decideup/src/services/DatabaseService.dart';
import 'package:decideup/src/services/GroupService.dart';
import 'package:decideup/src/services/UserService.dart';
import 'dart:js';

import 'package:decideup/src/navigation/navigation.dart';
import 'package:angular_router/angular_router.dart';

import 'package:decideup/src/navigation/routes.dart';


@Component(
  selector: 'app-root',
  styleUrls: ['root.css'],
  templateUrl: 'root.html',
  directives: [Navigation, coreDirectives, routerDirectives, Loading],
  providers: const [
    RootService,
    ClassProvider(UserService),
    ClassProvider(GroupService),
    ClassProvider(DatabaseService)
  ],
  exports: [RoutePaths, Routes],
)
class Root implements OnInit {
  RootService service;
  bool loading = false;

  Root(this.service) {
  }
  void ngOnInit() {
    context.callMethod("initMaterialize");

    service.onShowLoading.listen((showLoading) => this.loading = showLoading);
  }
}


