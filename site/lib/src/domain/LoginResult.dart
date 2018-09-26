import 'package:decideup/src/domain/DecideError.dart';
import 'package:decideup/src/domain/User.dart';

class LoginResult {
  User _user;
  DecideError _error;

  LoginResult(this._user, this._error);

  User user() {
    return _user;
  }
  DecideError error() {
    return _error;
  }
}