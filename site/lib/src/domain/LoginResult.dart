import 'package:decideup/src/domain/DecideError.dart';
import 'package:decideup/src/domain/User.dart';

class LoginResult {
  User user;
  DecideError error;

  LoginResult(this.user, this.error);
}