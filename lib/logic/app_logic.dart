import 'dart:ui';

import 'package:bodygoal/assets.dart';
import 'package:bodygoal/logic/common/page_routes.dart';
import 'package:bodygoal/logic/common/platform_info.dart';
import 'package:bodygoal/main.dart';
import 'package:bodygoal/router.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class AppLogic {
  Size _appSize = Size.zero;

  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// Indicates which orientations the app will allow be default. Affects Android/iOS devices only.
  /// Defaults to both landscape (hz) and portrait (vt)
  List<Axis> supportedOrientations = [Axis.vertical, Axis.horizontal];

  /// Allow a view to override the currently supported orientations. For example, [FullscreenVideoViewer] always wants to enable both landscape and portrait.
  /// If a view sets this override they are responsible for setting it back to null when finished
  List<Axis>? _supportedOrientationsOverride;
  set supportedOrientationsOverride(List<Axis>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  /// Initialize the app and all main actors
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    debugPrint('bootstrap start....');
    // set min-sizes for desktop apps
    if (PlatformInfo.isDesktop) {
      await DesktopWindow.setMinWindowSize($styles.sizes.minAppSize);
    }

    if (kIsWeb) {
      // SB: This is intentionally not a debugPrint, as it's a message for users who open the console on web.
      if (kDebugMode) {
        print(
          '''Thanks for checking out Tempus on the web!
        If you encounter any issues please report them at https://pulsereality.com.ng''',
        );
      }
      // Required on web to automically enable accessibility features
      WidgetsFlutterBinding.ensureInitialized().ensureSemantics();
    }

    // Load any bitmaps the views might need
    await AppBitmaps.init();

    // Set preferred referesh rate to the max possible (the OS may ignore this)
    if (!kIsWeb && PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    // Settings
    await settingsLogic.load();

    // Localizations
    await localeLogic.load();

    // Wait at least 1 frame to give Gorouter time to catch the inital deeplink
    await Future.delayed(1.milliseconds);

    // Flag boostStrap as complete
    isBootstrapComplete = true;

    // Load initial view (replace empty initial view which is covered by a native splash screen)
    bool showIntro = settingsLogic.hasCompletedOnboarding.value == false;
    if (showIntro) {
      appRouter.go(ScreenPaths.onboarding);
    } else {
      appRouter.go(initialDeeplink ?? ScreenPaths.home);
    }
  }

  Future<T?> showFullscreenDialogRoute<T>(BuildContext context, Widget child,
      {bool transparent = false}) async {
    return await Navigator.of(context).push<T>(
      PageRoutes.dialog<T>(child, duration: $styles.times.pageTransition),
    );
  }

  /// Called from the UI layer once a MediaQuery has been obtained
  void handleAppSizeChanged(Size appSize) {
    /// Disable landscape layout on smaller form factors
    bool isSmall = display.size.shortestSide / display.devicePixelRatio < 600;
    supportedOrientations =
        isSmall ? [Axis.vertical] : [Axis.vertical, Axis.horizontal];
    _updateSystemOrientation();
    _appSize = appSize;
  }

  Display get display => PlatformDispatcher.instance.displays.first;

  bool shouldUseNavRail() =>
      _appSize.width > _appSize.height && _appSize.height > 250;
  void _updateSystemOrientation() {
    final axisList = _supportedOrientationsOverride ?? supportedOrientations;
    debugPrint('updateDeviceOrientation, suportedAxis: $axisList');
    final orientations = <DeviceOrientation>[];
    if (axisList.contains(Axis.vertical)) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    if (axisList.contains(Axis.horizontal)) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }
}

class AppImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    this.imageCache.maximumSizeBytes = 250 << 20; // 250mb
    return super.createImageCache();
  }
}
