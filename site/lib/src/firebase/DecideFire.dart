
@JS()
library decidefire;


import 'dart:async';

import 'package:decideup/src/domain/DecideError.dart';
import 'package:decideup/src/domain/LoginResult.dart';
import 'package:decideup/src/domain/User.dart';
import 'package:decideup/src/services/GroupService.dart';
import 'package:decideup/src/services/TopicService.dart';
import 'package:js/js.dart';


@JS()
abstract class DecideFireJS {
  external factory DecideFireJS();
  external void checkEmail(String email, void Function(List<dynamic>, String /* error */) callback);
  external void signup(String email, String password, String displayName, void Function(DecideFireLoginResultJS) callback);
  external void login(String email, String password, void Function(DecideFireLoginResultJS) callback);
  external void currentUser(void Function(dynamic) callback);
  external void push(String path, dynamic obj, void Function(String /*uid*/) callback);
  external void save(String path, dynamic obj, void Function() callback);
  external void get(String path, void Function(dynamic result) callback);
  external List<String> getKeysForObject(dynamic jsObject);
  external void logout();
}

@JS()
abstract class DecideFireErrorJS {
  external String code();
  external String message();
}

@JS()
abstract class DecideFireLoginResultJS {
  external dynamic user();
  external DecideFireErrorJS error();
}

@JS()
@anonymous
class GroupJS {
  external String get name;
  external String get description;

  external factory GroupJS({String name, String description, List<String> users});
}

class FireLoginResult {
  dynamic user;
  DecideError error;
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

  List<String> getKeysForObject(dynamic obj) {
    return js.getKeysForObject(obj);
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
    this.js.get(path, allowInterop((result) {
      completer.complete(result);
    }));

    return completer.future;
  }

  Future<dynamic> currentUser() async {
    Completer<dynamic> completer = new Completer();
    this.js.currentUser(allowInterop((user) {
      if(user != null) {
        completer.complete(user);
      } else {
        completer.complete(null);
      }
    }));
    return completer.future;
  }

  Future<FireLoginResult> signup(String email, String password, String displayName) async {
    Completer<FireLoginResult> completer = new Completer();
    this.js.signup(email, password, displayName, allowInterop((jsResult)  {
      if(jsResult.user() != null) {
        var result = FireLoginResult();
        result.user = jsResult.user();
        completer.complete(result);
      } else {
        var result = FireLoginResult();
        result.error = DecideError(jsResult.error().code(), jsResult.error().message());
        completer.complete(result);
      }
    }));
    return completer.future;
  }

  Future<FireLoginResult> login(String email, String password) async {
    Completer<FireLoginResult> completer = new Completer();
    this.js.login(email, password, allowInterop((jsResult)  {
      if(jsResult.user() != null) {
        var result = FireLoginResult();
        result.user = jsResult.user();
        completer.complete(result);
      } else {
        var result = FireLoginResult();
        result.error = DecideError(jsResult.error().code(), jsResult.error().message());
        completer.complete(result);
      }
    }));

    return completer.future;
  }
}