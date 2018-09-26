import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:decideup/root.template.dart' as ng;
import 'package:firebase/firebase.dart';

import 'main.template.dart' as self;

const useHashLS = false;
@GenerateInjector(
  routerProvidersHash, // You can use routerProviders in production
)
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.RootNgFactory, createInjector: injector);
}
