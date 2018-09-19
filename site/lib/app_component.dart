
import 'package:angular/angular.dart';
import 'dart:js';

import 'src/todo_list/todo_list_component.dart';
import 'navigation.dart';
// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components


@Component(
  selector: 'app-root',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [Navigation],
)
class AppComponent implements OnInit {
  // Nothing here yet. All logic is in TodoListComponent.

  void ngOnInit() {
    context.callMethod("initMaterialize");
  }
}
