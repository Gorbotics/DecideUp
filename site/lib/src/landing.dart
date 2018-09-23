import 'package:angular/angular.dart';
import 'dart:js';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'landing',
  templateUrl: 'landing.html',
)
class Landing implements OnInit, OnActivate {
  void ngOnInit() {
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    context.callMethod("initMaterialize");
  }
}
