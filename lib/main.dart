import 'package:bodygoal/logic/app_logic.dart';
import 'package:bodygoal/logic/common/app_shortcuts.dart';
import 'package:bodygoal/logic/locale_logic.dart';
import 'package:bodygoal/logic/settings_logic.dart';
import 'package:bodygoal/providers.dart';
import 'package:bodygoal/router.dart';
import 'package:bodygoal/styles/styles.dart';
import 'package:bodygoal/ui/app_scaffold.dart';
import 'package:bodygoal/ui/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Start app
  registerSingletons();
  runApp(BodyGoal());
}

class BodyGoal extends StatelessWidget with GetItMixin {
  BodyGoal({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    return MaterialApp.router(
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      locale: locale == null ? null : Locale(locale),
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.routerDelegate,
      shortcuts: AppShortcuts.defaults,
      themeMode: ThemeMode.dark, // keep dark mode as default
      darkTheme: AppTheme.dark(),
      theme: AppTheme.light(),
      color: $styles.colors.black,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // builder: (_, router) {
      //   return MultiProvider(
      //     providers: Providers.providers,
      //     child: router!,
      //   );
      // },
    );
  }
}

/// Create singletons (logic and services) that can be shared across the app.
void registerSingletons() {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  // Localizations
  GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
}

// Add syntax sugar fro quickly accessing the main "logic" controller in the app
// We deliberately do not create shortcuts for services, to discourage their use directly in the view/widget layer
AppLogic get appLogic => GetIt.I.get<AppLogic>();
SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();
LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();

/// Global helpers for readability
AppLocalizations get $strings => localeLogic.strings;
AppStyle get $styles => BodyGoalScaffold.style;
