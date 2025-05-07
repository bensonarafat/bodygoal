import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/app_scaffold.dart';
import 'package:bodygoal/ui/common/utils/navigation_service.dart';
import 'package:bodygoal/ui/screens/onboarding/onboarding_screen.dart';
import 'package:bodygoal/ui/screens/page_not_found/page_not_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenPaths {
  static String home = "/home";
  static String onboarding = "/onboarding";
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
          ]),
    ]);

String? _initialDeeplink;
String? get initialDeeplink => _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete &&
      state.uri.path != ScreenPaths.onboarding) {
    debugPrint(
        'Redirecting from ${state.uri.path} to ${ScreenPaths.onboarding}');
    _initialDeeplink ??= state.uri.toString();
    return ScreenPaths.onboarding;
  }

  if (appLogic.isBootstrapComplete &&
      state.uri.path == ScreenPaths.onboarding) {
    debugPrint("Redirecting from ${state.uri.path} to ${ScreenPaths.home}");
    return ScreenPaths.home;
  }

  if (!kIsWeb) debugPrint('Navigate to ${state.uri}');
  return null; // do nothing
}
