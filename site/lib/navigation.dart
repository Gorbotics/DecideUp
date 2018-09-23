import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/routes.dart';

@Component(
  selector: 'app-navigation',
  templateUrl: 'navigation.html',
  directives: [routerDirectives],
  exports: [RoutePaths, Routes],
)
class Navigation {
  var name = 'Angular';
}
