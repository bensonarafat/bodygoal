import 'package:bodygoal/data/remote/dio_interceptors/error_interceptor.dart';
import 'package:bodygoal/data/repositories/onboarding_repository.dart';
import 'package:bodygoal/ui/screens/onboarding/provider/onboarding_provider.dart';
import 'package:dio/dio.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

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

  static final List<SingleChildWidget> _repositoryProviders = [
    Provider<OnboardingRepository>.value(
      value: OnboardingRespositoryImpl(),
    )
  ];

  static final List<SingleChildWidget> _changeProviders = [
    ChangeNotifierProxyProvider<OnboardingRepository, OnboardingProvider>(
        create: (context) =>
            OnboardingProvider(context.read<OnboardingRepository>()),
        update: (context, repository, provider) =>
            provider ?? OnboardingProvider(repository)),
  ];

  static List<SingleChildWidget> providers = [
    ..._apiProviders,
    ..._serviceProviders,
    ..._repositoryProviders,
    ..._changeProviders,
  ];
}
