import 'package:angular/angular.dart';
import 'dart:js';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'landing',
  templateUrl: 'landing.html',
)
class Landing implements OnActivate {
  @override
  void onActivate(RouterState previous, RouterState current) {
    // calling the javascript init for materialize
    context.callMethod("initMaterialize");
  }
}
