import 'dart:async';

import 'package:angular/angular.dart';


@Injectable()
class RootService {
  StreamController<bool> _isUserLoggedInController;
  Stream<bool> get onIsUserLoggedIn => _isUserLoggedInController.stream;
  bool _isUserLoggedIn = false;
  bool get isUserLoggedIn => _isUserLoggedIn;
  set showLogin(bool value) {
    _showLogin = value;
    _showLoginController.add(value);
  }

  StreamController<bool> _showLoginController;
  Stream<bool> get onShowLogin => _showLoginController.stream;
  bool _showLogin = true;
  bool get showLogin => _showLogin;
  set isUserLoggedIn(bool value) {
    _isUserLoggedIn = value ?? false;
    _isUserLoggedInController.add(_isUserLoggedIn);
  }

  StreamController<bool> _showLoadingController;
  Stream<bool> get onShowLoading => _showLoadingController.stream;
  bool _showLoading = true;
  bool get showLoading => _showLoading;
  set showLoading(bool value) {
    _showLoading = value ?? false;
    _showLoadingController.add(_showLoading);
  }

  RootService() {
    _isUserLoggedInController = new StreamController<bool>.broadcast(
        onListen: () => _isUserLoggedInController.add(_isUserLoggedIn)
    );
    _showLoginController = new StreamController<bool>.broadcast(
        onListen: () => _showLoginController.add(_showLogin)
    );
    _showLoadingController = new StreamController<bool>.broadcast(
        onListen: () => _showLoginController.add(_showLoading)
    );
  }



}