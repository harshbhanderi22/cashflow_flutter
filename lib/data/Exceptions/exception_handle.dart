// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppException implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final  _message;
  // ignore: prefer_typing_uninitialized_variables
  final  _prefix;
  AppException(
    this._message,
    this._prefix,
  );

  @override
  String toString() {
     return _prefix + _message;
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? message) : super(message, "Communication Failed");
}

class BadRequestException extends AppException {
  BadRequestException(String? message) : super(message, "Invalid Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? message)
      : super(message, "Unauthorised Request");
}

class InvalidInputException extends AppException {
  InvalidInputException(String? message) : super(message, "Invalid Data");
}

class SocketException extends AppException {
  SocketException(String? message) : super(message, "Network Error");
}

class NoServerException extends AppException {
  NoServerException(String? message) : super(message, "No Server Found");
}

class DefaultException extends AppException {
  DefaultException(String? message) : super(message, "Something Went Wrong");
}