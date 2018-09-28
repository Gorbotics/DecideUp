import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/RootService.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/services/UserService.dart';
import 'routes.dart';

@Component(
  selector: 'app-navigation',
  templateUrl: 'navigation.html',
  directives: [routerDirectives, coreDirectives],
  exports: [RoutePaths, Routes],
)
class Navigation {
  bool showLogin = true;
  bool showUserInfo = false;

  String displayName;

  final UserService userService;
  final RootService rootService;
  Navigation(this.userService, this.rootService) {
    this.rootService.onIsUserLoggedIn.listen((isLoggedOn) => refreshUser(isLoggedOn));
    this.userService.current().then((user) => setUser(user));
  }

  void refreshUser(bool isLoggedOn) {
    if(isLoggedOn) {
      userService.current().then((user) => setUser(user));
    }
  }

  void setUser(User user) {
    if(user != null) {
      showLogin = false;
      showUserInfo = true;
      displayName = user.name();
    }
  }

  logout() {
    this.userService.logout();
    this.rootService.isUserLoggedIn = false;
    showLogin = true;
    showUserInfo = false;
  }

  login() {
    showLogin = false;
  }

}