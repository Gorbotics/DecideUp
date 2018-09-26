class DecideError {
  String _code;
  String _message;

  DecideError(this._code, this._message);

  String code() {
    return _code;
  }

  String message() {
    return _message;
  }
}