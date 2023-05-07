import 'dart:io';

import 'package:dio/dio.dart';

class ServerException implements Exception {}

class DioException implements Exception {

  late String message;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        final data = dioError.response!.data;
        if(data != null){
          if(data.runtimeType == List<dynamic>){
            message = data[0];
            break;
          }
          message = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          );
          break;
        }
        message = dioError.message!;
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        final error = dioError.error;
        if(error is SocketException){
          message = error.message;
          break;
        }
        if(dioError.message != null && dioError.message!.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return '$error';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}