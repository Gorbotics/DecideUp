
@JS()
library decidefire;

import 'dart:async';

import 'package:decideup/src/domain/DecideError.dart';
import 'package:decideup/src/domain/LoginResult.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:js/js.dart';

@JS()
abstract class DecideFireJS {
  external factory DecideFireJS();
  external void checkEmail(String email, void Function(List<String>, String /* error */) callback);
  external void signup(String email, String password, String displayName, void Function(DecideFireLoginResultJS) callback);
  external void login(String email, String password, void Function(DecideFireLoginResultJS) callback);
  external void currentUser(void Function(DecideFireUserJS) callback);
  external void logout();
}

@JS()
abstract class DecideFireErrorJS {
  external String code();
  external String message();
}

@JS()
abstract class DecideFireUserJS {
  external String uid();
  external String name();
}

@JS()
abstract class DecideFireLoginResultJS {
  external DecideFireUserJS user();
  external DecideFireErrorJS error();
}

class DecideFire {
  final DecideFireJS js = DecideFireJS();
  DecideFire();
  Future<List<String>> checkEmail(String email) async {
    Completer<List<String>> completer = new Completer();
    this.js.checkEmail(email, (methods, error) {
      if(error != "") {
        completer.completeError(error);
      } else {
        List<String> methodStrings = new List();
        methods.forEach((method) => methodStrings.add(method.toString()));
        completer.complete(methodStrings);
      }
    });

    return completer.future;
  }

  void logout() {
    this.js.logout();
  }

  Future<User> currentUser() async {
    Completer<User> completer = new Completer();
    this.js.currentUser((user) {
      if(user != null) {
        completer.complete(User(user.uid(), user.name()));
      } else {
        completer.complete(null);
      }
    });
    return completer.future;
  }

  Future<LoginResult> signup(String email, String password, String displayName) async {
    Completer<LoginResult> completer = new Completer();
    this.js.signup(email, password, displayName, (result)  {
      if(result.user() != null) {
        completer.complete(LoginResult(User(result.user().uid(), result.user().name()), null));
      } else {
        completer.complete(LoginResult(null, DecideError(result.error().code(), result.error().message())));
      }
    });
    return completer.future;
  }

  Future<LoginResult> login(String email, String password) async {
    Completer<LoginResult> completer = new Completer();
    this.js.login(email, password, (result)  {
      if(result.user() != null) {
        completer.complete(LoginResult(User(result.user().uid(), result.user().name()), null));
      } else {
        completer.complete(LoginResult(null, DecideError(result.error().code(), result.error().message())));
      }
    });

    return completer.future;
  }
}