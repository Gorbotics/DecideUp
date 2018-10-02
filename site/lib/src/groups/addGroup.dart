
import 'package:angular/angular.dart';
import 'package:angular_components/focus/focus.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/navigation/route_paths.dart';
import 'package:decideup/src/services/DomainService.dart';

@Component(
  selector: 'addGroup',
  templateUrl: 'addGroup.html',
  directives: [coreDirectives, formDirectives, AutoFocusDirective],
)
class AddGroup implements OnActivate {
  DatabaseService databaseService;
  Router router;

  String groupName;
  String groupDescription;

  User currentUser;

  AddGroup(this.databaseService, this.router);

  @override
  void onActivate(RouterState previous, RouterState current) {
    databaseService.user.current().then((user) => this.currentUser = user);
  }

  void add() async {
    final Group saved = await databaseService.group.save(Group(groupName, groupDescription));
    currentUser.addGroup(saved);
    this.router.navigate(RoutePaths.viewGroup.toUrl(parameters: {'uid': saved.uid}));
  }
}
