
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/src/services/UserService.dart';

@Component(
  selector: 'addGroup',
  templateUrl: 'addGroup.html',
  directives: [coreDirectives, formDirectives],
)
class AddGroup implements OnActivate {
  UserService userService;
  Router router;

  String groupName;
  String groupDescription;

  AddGroup(this.userService, this.router);

  @override
  void onActivate(RouterState previous, RouterState current) {
  }

  void add() {

  }
}