import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/app_scaffold.dart';
import 'package:bodygoal/ui/common/utils/navigation_service.dart';
import 'package:bodygoal/ui/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:bodygoal/ui/screens/auth/login/login_screen.dart';
import 'package:bodygoal/ui/screens/auth/reset_password/reset_password_screen.dart';
import 'package:bodygoal/ui/screens/auth/signup/message_screen.dart';
import 'package:bodygoal/ui/screens/auth/signup/signup_part_one_a.dart';
import 'package:bodygoal/ui/screens/auth/signup/started_screen.dart';
import 'package:bodygoal/ui/screens/auth/signup/title_screen.dart';
import 'package:bodygoal/ui/screens/onboarding/onboarding_screen.dart';
import 'package:bodygoal/ui/screens/page_not_found/page_not_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenPaths {
  static String home = "/home";
  static String onboarding = "/onboarding";
  static String login = "/login";
  static String forgotPassword = "/forgot-password";
  static String resetPassword = "/reset-password";
  static String register = "/register";
  static String authmessage = "/auth-message";
  static String titlepage = "/title-page";
  static String signupPartOneA = "/sign-up-part-one-a";
}

class AppRoute extends GoRoute {
  final bool useFade;
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = true})
      : super(
            path: path,
            routes: routes,
            pageBuilder: (context, state) {
              final pageContent = Scaffold(
                body: builder(state),
                resizeToAvoidBottomInset: false,
              );

              if (useFade) {
                return CustomTransitionPage(
                    child: pageContent,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    });
              }

              return CupertinoPage(child: pageContent);
            });
}

/// routing table, matches string paths to UI screens, optionally parses params from the paths
final appRouter = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    debugLogDiagnostics: false,
    redirect: _handleRedirect,
    errorPageBuilder: (context, state) =>
        MaterialPage(child: PageNotFound(state.uri.toString())),
    routes: [
      ShellRoute(
          builder: (context, router, navigator) {
            return BodyGoalScaffold(
              child: navigator,
            );
          },
          routes: [
            AppRoute(ScreenPaths.onboarding, (_) => const OnboardingScreen()),
            AppRoute(ScreenPaths.login, (_) => const LoginScreen()),
            AppRoute(ScreenPaths.forgotPassword,
                (_) => const ForgotPasswordScreen()),
            AppRoute(
                ScreenPaths.resetPassword, (_) => const ResetPasswordScreen()),
            AppRoute(ScreenPaths.register, (_) => const StartedScreen()),
            AppRoute(ScreenPaths.authmessage, (_) => const MessageScreen()),
            AppRoute(ScreenPaths.titlepage, (_) => const TitleScreen()),
            AppRoute(ScreenPaths.signupPartOneA, (_) => const SignupPartOneA())
          ]),
    ]);

String? _initialDeeplink;
String? get initialDeeplink => _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  final allowedPaths = [
    ScreenPaths.onboarding,
    ScreenPaths.login,
    ScreenPaths.forgotPassword,
    ScreenPaths.resetPassword,
    ScreenPaths.register,
    ScreenPaths.authmessage,
    ScreenPaths.titlepage,
    ScreenPaths.signupPartOneA,
  ];

  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && !allowedPaths.contains(state.uri.path)) {
    debugPrint(
        'Redirecting from ${state.uri.path} to ${ScreenPaths.onboarding}');
    _initialDeeplink ??= state.uri.toString();
    return ScreenPaths.onboarding;
  }

  // navigate to the home page when isBootrapComplete and Login //TODO:: coming to this later
  if (appLogic.isBootstrapComplete &&
      state.uri.path == ScreenPaths.onboarding) {
    debugPrint("Redirecting from ${state.uri.path} to ${ScreenPaths.home}");
    return ScreenPaths.home;
  }

  if (!kIsWeb) debugPrint('Navigate to ${state.uri}');
  return null; // do nothing
}
