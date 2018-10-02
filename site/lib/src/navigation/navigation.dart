import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/RootService.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/services/DomainService.dart';
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

  final DatabaseService databaseService;
  final RootService rootService;
  final Router router;

  Navigation(this.databaseService, this.rootService, this.router) {
    this.rootService.onIsUserLoggedIn.listen((isLoggedOn) => refreshUser(isLoggedOn));
    this.databaseService.user.current().then((user) => setUser(user));
  }

  void refreshUser(bool isLoggedOn) {
    if(isLoggedOn) {
      databaseService.user.current().then((user) => setUser(user));
    }
  }

  void setUser(User user) {
    if(user != null) {
      showLogin = false;
      showUserInfo = true;
      displayName = user.name;
    }
  }

  logout() {
    this.databaseService.user.logout();
    this.rootService.isUserLoggedIn = false;
    showLogin = true;
    showUserInfo = false;
  }

  login() {
    showLogin = false;
  }

  goToLogin() {
    router.navigate(RoutePaths.login.toUrl(parameters: {'isSignUp': "false"}));
  }

  goToSignUp() {
    router.navigate(RoutePaths.login.toUrl(parameters: {'isSignUp': "true"}));
  }
}