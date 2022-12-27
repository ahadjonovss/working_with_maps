import 'package:dio/dio.dart';

class BadRequestException extends DioError{
  BadRequestException(RequestOptions r):super(requestOptions: r);
  @override
  String toString() {
    return "Noto'g'ri so'rov jo'natildi!";
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return "Noaniq xatolik yuz berdi, iltimos qayta urinib ko'ring";
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return "Xatolik yuz berdi";
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return "So'rov rad etildi";
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return "So'ralgan ma'lumot topilmadi";
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return "Internet mavjud emas, iltimos tarmoqqa ulanib qayta urining";
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() {
    return "So'rov jo'natishda chegaralangan vaqtdan o'tib ketdi, iltimos qaytadan urining";
  }
}

class ReceiveTimeOutException extends DioError{
  ReceiveTimeOutException(RequestOptions r):super(requestOptions: r);

  @override
  String toString() {
    return "Ma'lumot qabul qilishda chegaralangan vaqtdan o'tib ketdi, iltimos qayta urining";
  }
}