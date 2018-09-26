import 'package:angular/angular.dart';
import 'package:decideup/RootService.dart';
import 'package:decideup/src/services/UserService.dart';
import 'dart:js';

import 'package:decideup/src/navigation/navigation.dart';
import 'package:angular_router/angular_router.dart';

import 'package:decideup/src/navigation/routes.dart';


@Component(
  selector: 'app-root',
  styleUrls: ['root.css'],
  templateUrl: 'root.html',
  directives: [Navigation, routerDirectives],
  providers: const [RootService, ClassProvider(UserService)],
  exports: [RoutePaths, Routes],
)
class Root implements OnInit {
  var showLogin = true;
  RootService service;

  Root(this.service) {
    this.service.onShowLogin.listen((value) => this.showLogin = value);
  }
  void ngOnInit() {
    context.callMethod("initMaterialize");
  }
}


