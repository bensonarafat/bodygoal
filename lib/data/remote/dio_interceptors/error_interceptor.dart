import 'dart:developer';

import 'package:bodygoal/data/remote/dto/api_error.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.message?.startsWith("SocketException: Failed host lookup") ??
        false) {
      final newError = err.copyWith(
          error: ApiError(code: -1, message: "No Internet Connection"));
      return handler.next(newError);
    }

    if (err.response?.data != null) {
      try {
        if (err.response?.data is Map<String, dynamic>) {
          final error = ApiError.fromJson(err.response?.data);
          final newError = err.copyWith(error: error);
          return handler.next(newError);
        }
      } catch (_) {
        // ignore: no_wildcard_variable_uses
        log("Error parsing error response: $_");
      }
    }

    handler.next(err);
  }
}
