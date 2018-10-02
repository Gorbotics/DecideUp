import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/RootService.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/navigation/route_paths.dart';
import 'package:decideup/src/services/DomainService.dart';


@Component(
  selector: 'dashboard',
  templateUrl: 'dashboard.html',
  directives: [coreDirectives, formDirectives],
  styleUrls: ['dashboard.css'],
)
class Dashboard implements OnActivate {
  RootService rootService;
  DatabaseService databaseService;

  Router router;
  String displayName;

  List<Group> groups = List();

  Dashboard(this.rootService, this.databaseService, this.router) {
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    this.rootService.showLoading = true;
    this.databaseService.user.current().then((user) {
      if(user != null) {
        displayName = user.name;
        user.groups().then((groups) {
          this.groups = groups;
          this.rootService.showLoading = false;
        });
      } else {
        this.rootService.showLoading = false;
        router.navigate(RoutePaths.login.toUrl());
      }
    });
  }

  void viewGroup(Group group) {
    router.navigate(RoutePaths.viewGroup.toUrl(parameters: {'uid': group.uid}));
  }

  void addGroup() {
    router.navigate(RoutePaths.addGroup.toUrl());
  }
}