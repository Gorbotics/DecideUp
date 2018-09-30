
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/src/domain/Group.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/navigation/route_paths.dart';
import 'package:decideup/src/services/GroupService.dart';
import 'package:decideup/src/services/UserService.dart';

@Component(
  selector: 'addTopic',
  templateUrl: 'addTopic.html',
  directives: [coreDirectives, formDirectives],
)
class AddTopic implements OnActivate {
  GroupService groupService;
  UserService userService;
  Router router;

  String topicName;
  String topicDescription;

  User currentUser;

  AddTopic(this.userService, this.router, this.groupService);

  @override
  void onActivate(RouterState previous, RouterState current) {
    userService.current().then((user) => this.currentUser = user);
  }

  void add() async {
//    final Group saved = await groupService.save(Group(name: groupName, description: groupDescription));
//    this.router.navigate(RoutePaths.viewGroup.toUrl(parameters: {'uid': saved.uid}));
  }
}
