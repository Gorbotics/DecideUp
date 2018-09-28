
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/firebase/DecideFire.dart';
import 'package:decideup/src/navigation/route_paths.dart';
import 'package:decideup/src/services/DatabaseService.dart';
import 'package:decideup/src/services/GroupService.dart';
import 'package:decideup/src/services/UserService.dart';
import 'package:js/js_util.dart' as util;

@Component(
  selector: 'addGroup',
  templateUrl: 'addGroup.html',
  directives: [coreDirectives, formDirectives],
)
class AddGroup implements OnActivate {
  GroupService groupService;
  UserService userService;
  Router router;

  String groupName;
  String groupDescription;

  User currentUser;

  AddGroup(this.userService, this.router, this.groupService);

  @override
  void onActivate(RouterState previous, RouterState current) {
    userService.current().then((user) => this.currentUser = user);
  }

  void add() async {
    final Group saved = await groupService.save(Group(name: groupName, description: groupDescription));
    this.router.navigate(RoutePaths.viewGroup.toUrl(parameters: {'uid': saved.uid}));
  }
}
