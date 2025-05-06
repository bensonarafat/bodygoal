import 'package:bodygoal/data/remote/dio_interceptors/error_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:provider/single_child_widget.dart';

abstract class Providers {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      LogInterceptor(requestBody: false, responseBody: false),
      ErrorInterceptor()
    ]);

  static final List<SingleChildWidget> _apiProviders = [];

  static final List<SingleChildWidget> _serviceProviders = [];

  static final List<SingleChildWidget> _repositoryProviders = [];

  static final List<SingleChildWidget> _changeProviders = [];

  static List<SingleChildWidget> providers = [
    ..._apiProviders,
    ..._serviceProviders,
    ..._repositoryProviders,
    ..._changeProviders,
  ];
}
