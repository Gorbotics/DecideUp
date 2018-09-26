
class User {
  String _uid;
  String _name;

  User(this._uid, this._name);

  String name() {
    return _name;
  }
  String uid() {
    return _uid;
  }
}