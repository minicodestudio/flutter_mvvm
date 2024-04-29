class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return 'AppException{_message: $_message, _prefix: $_prefix}';
  }

}

class FetchDataException extends AppException {

  FetchDataException([String? message]) : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {

  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnauthroizedException extends AppException {

  UnauthroizedException([String? message]) : super(message, 'Unauthroized request');
}

class InvalidInputException extends AppException {

  InvalidInputException([String? message]) : super(message, 'InvalidInput request');
}