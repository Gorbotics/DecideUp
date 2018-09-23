
import 'package:angular/angular.dart';
import 'dart:js';

import 'navigation.dart';
import 'package:angular_router/angular_router.dart';

import 'src/routes.dart';
// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components


@Component(
  selector: 'app-root',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [Navigation, routerDirectives],
  exports: [RoutePaths, Routes],
)
class AppComponent implements OnInit {
  // Nothing here yet. All logic is in TodoListComponent.

  void ngOnInit() {
    //hmm
    context.callMethod("initMaterialize");
  }
}
