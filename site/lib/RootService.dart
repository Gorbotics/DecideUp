import 'dart:async';

import 'package:angular/angular.dart';


@Injectable()
class RootService {
  bool _isUserLoggedIn = false;
  bool get isUserLoggedIn => _isUserLoggedIn;
  set isUserLoggedIn(bool value) {
    _isUserLoggedIn = value ?? false;
    _isUserLoggedInController.add(_isUserLoggedIn);
  }

  StreamController<bool> _isUserLoggedInController;
  Stream<bool> get onIsUserLoggedIn => _isUserLoggedInController.stream;

  RootService() {
    _isUserLoggedInController = new StreamController<bool>.broadcast(
        onListen: () => _isUserLoggedInController.add(_isUserLoggedIn)
    );
    _showLoginController = new StreamController<bool>.broadcast(
        onListen: () => _showLoginController.add(_showLogin)
    );
  }

  bool _showLogin = true;
  bool get showLogin => _showLogin;
  set showLogin(bool value) {
    _showLogin = value;
    _showLoginController.add(value);
  }

  StreamController<bool> _showLoginController;
  Stream<bool> get onShowLogin => _showLoginController.stream;
}