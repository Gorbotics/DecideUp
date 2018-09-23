import 'dart:js';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'login',
  templateUrl: 'login.html',
)
class Login implements OnActivate{
  var name = 'Angular';

  @override
  void onActivate(RouterState previous, RouterState current) {
    context.callMethod("initLogin");
  }
}
