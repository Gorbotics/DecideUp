import 'package:angular_router/angular_router.dart';

import 'package:decideup/src/landing.template.dart' as landing_template;
import 'package:decideup/src/login/login.template.dart' as login_template;
import 'package:decideup/src/dashboard/dashboard.template.dart' as dashboard_template;
import 'package:decideup/src/groups/addGroup.template.dart' as addGroup_template;
import 'package:decideup/src/groups/viewGroup.template.dart' as viewGroup_template;
import 'package:decideup/src/navigation/route_paths.dart';

export 'package:decideup/src/navigation/route_paths.dart';
//export 'package:decideup/src/navigation/navigation.dart';

class Routes {
  static final landing = RouteDefinition(
    routePath: RoutePaths.landing,
    component: landing_template.LandingNgFactory,
  );

  static final login = RouteDefinition(
    routePath: RoutePaths.login,
    component: login_template.LoginNgFactory,
  );

  static final dashboard = RouteDefinition(
    routePath: RoutePaths.dashboard,
    component: dashboard_template.DashboardNgFactory,
  );

  static final addGroup = RouteDefinition(
    routePath: RoutePaths.addGroup,
    component: addGroup_template.AddGroupNgFactory,
  );

  static final viewGroup = RouteDefinition(
    routePath: RoutePaths.viewGroup,
    component: viewGroup_template.ViewGroupNgFactory,
  );

  static final all = <RouteDefinition>[
    landing,
    login,
    dashboard,
    addGroup,
    viewGroup,
  ];
}