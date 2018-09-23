import 'package:angular_router/angular_router.dart';

import 'package:decideup/src/landing.template.dart' as landing_template;
import 'package:decideup/src/login.template.dart' as login_template;
import 'route_paths.dart';

export 'route_paths.dart';

class Routes {
  static final landing = RouteDefinition(
    routePath: RoutePaths.landing,
    component: landing_template.LandingNgFactory,
  );

  static final login = RouteDefinition(
    routePath: RoutePaths.login,
    component: login_template.LoginNgFactory,
  );

  static final all = <RouteDefinition>[
    landing,
    login,
  ];
}