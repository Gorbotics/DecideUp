import 'package:angular/angular.dart';
import 'dart:js';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/RootService.dart';

export 'package:decideup/src/navigation/routes.dart';

@Component(
  selector: 'landing',
  templateUrl: 'landing.html',
)

class Landing implements OnActivate {
  RootService rootService;

  Landing(this.rootService);

  @override
  void onActivate(RouterState previous, RouterState current) {
    // calling the javascript init for materialize
    context.callMethod("initMaterialize");
  }
}
