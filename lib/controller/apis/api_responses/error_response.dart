import 'package:dio/dio.dart';

import '../../../models/connectivity/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is DioException) {
      try {
        switch (error.type) {
          case DioExceptionType.cancel:
            errorDescription = "Request to API server was cancelled";
            break;
          case DioExceptionType.connectionTimeout:
            errorDescription = "Connection timeout with API server";
            break;
          case DioExceptionType.unknown:
            errorDescription =
            "Connection to API server failed due to internet connection";
            break;
          case DioExceptionType.receiveTimeout:
            errorDescription =
            "Receive timeout in connection with API server";
            break;
            case DioExceptionType.connectionError:
            errorDescription =
            "Connecting Time-out Check Internet Connectivity";
            break;

          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 401:
                errorDescription=error.response?.data['error'];
              case 400:
                print(error.response.toString());
                errorDescription=error.response?.data['error'];
              case 404:
                errorDescription=error.response?.data['error'];
              case 503:
                errorDescription = error.response?.statusMessage;
                break;
              default:
                ErrorResponse errorResponse =
                ErrorResponse.fromJson(error.response?.data);
                if (errorResponse.errors.isNotEmpty) {
                  errorDescription = errorResponse;
                } else {
                  errorDescription =
                  "Failed to load data - status code: ${error.response?.statusCode}";
                }
            }
            break;
          case DioExceptionType.sendTimeout:
            errorDescription = "Send timeout with server";
            break;
          case DioExceptionType.badCertificate:
            // TODO: Handle this case.
          case DioExceptionType.connectionError:
            // TODO: Handle this case.
        }
            } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}