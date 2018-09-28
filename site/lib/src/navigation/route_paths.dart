import 'package:angular_router/angular_router.dart';

class RoutePaths {
  static final landing = RoutePath(path: '');
  static final login = RoutePath(path: 'login');
  static final dashboard = RoutePath(path: 'dashboard');
  static final addGroup = RoutePath(path: 'addGroup');
  static final viewGroup = RoutePath(path: 'group/:uid');
  static final addTopic = RoutePath(path: 'addTopic');
  static final viewTopic = RoutePath(path: 'topic/:uid');
}