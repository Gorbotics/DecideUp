
@JS()
library decidefire;


import 'dart:async';

import 'package:decideup/src/domain/DecideError.dart';
import 'package:decideup/src/domain/LoginResult.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:js/js.dart';

@JS("Object.keys")
external List<String> getKeysForObject(jsObject);

@JS()
abstract class DecideFireJS {
  external factory DecideFireJS();
  external void checkEmail(String email, void Function(List<dynamic>, String /* error */) callback);
  external void signup(String email, String password, String displayName, void Function(DecideFireLoginResultJS) callback);
  external void login(String email, String password, void Function(DecideFireLoginResultJS) callback);
  external void currentUser(void Function(DecideFireUserJS) callback);
  external void push(String path, dynamic obj, void Function(String /*uid*/) callback);
  external void save(String path, dynamic obj, void Function() callback);
  external void get(String path, void Function(dynamic result) callback);
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

@JS()
@anonymous
class GroupJS {
  external String get name;
  external String get description;

  external factory GroupJS({String name, String description, List<String> users});
}

//class

class DecideFire {
  final DecideFireJS js = DecideFireJS();
  DecideFire();
  Future<List<String>> checkEmail(String email) async {
    Completer<List<String>> completer = new Completer();
    this.js.checkEmail(email, allowInterop((methods, error) {
      if(error != "") {
        completer.completeError(error);
      } else {
        List<String> methodStrings = new List();
        methods.forEach((method) => methodStrings.add(method.toString()));
        completer.complete(methodStrings);
      }
    }));

    return completer.future;
  }

  void logout() {
    this.js.logout();
  }

  Future<String> push(String path, dynamic obj) {
    Completer<String> completer = new Completer();
    this.js.push(path, obj, allowInterop((result) => completer.complete(result)));
    return completer.future;
  }

  Future<void> save(String path, dynamic obj) {
    Completer<void> completer = new Completer();
    this.js.save(path, obj, allowInterop(() => completer.complete()));
    return completer.future;
  }

  Future<dynamic> get(String path) {
    Completer<dynamic> completer = new Completer();
    this.js.get(path, allowInterop((result) => completer.complete(result)));
    return completer.future;
  }

  Future<User> currentUser() async {
    Completer<User> completer = new Completer();
    this.js.currentUser(allowInterop((user) {
      if(user != null) {
        completer.complete(User(user.uid(), user.name()));
      } else {
        completer.complete(null);
      }
    }));
    return completer.future;
  }

  Future<LoginResult> signup(String email, String password, String displayName) async {
    Completer<LoginResult> completer = new Completer();
    this.js.signup(email, password, displayName, allowInterop((result)  {
      if(result.user() != null) {
        completer.complete(LoginResult(User(result.user().uid(), result.user().name()), null));
      } else {
        completer.complete(LoginResult(null, DecideError(result.error().code(), result.error().message())));
      }
    }));
    return completer.future;
  }

  Future<LoginResult> login(String email, String password) async {
    Completer<LoginResult> completer = new Completer();
    this.js.login(email, password, allowInterop((result)  {
      if(result.user() != null) {
        completer.complete(LoginResult(User(result.user().uid(), result.user().name()), null));
      } else {
        completer.complete(LoginResult(null, DecideError(result.error().code(), result.error().message())));
      }
    }));

    return completer.future;
  }
}