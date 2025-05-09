import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PlatformInfo {
  static const _desktopPlatforms = [
    TargetPlatform.macOS,
    TargetPlatform.windows,
    TargetPlatform.linux
  ];
  static const _mobilePlatforms = [TargetPlatform.android, TargetPlatform.iOS];

  static bool get isDesktop =>
      _desktopPlatforms.contains(defaultTargetPlatform) && !kIsWeb;
  static bool get isDesktopOrWeb => isDesktop || kIsWeb;
  static bool get isMobile =>
      _mobilePlatforms.contains(defaultTargetPlatform) && !kIsWeb;

  static double get pixelRatio =>
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  static bool get isWinddows => defaultTargetPlatform == TargetPlatform.windows;
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  static Future<bool> get isConnected async =>
      await InternetConnectionChecker.instance.hasConnection;
  static Future<bool> get isDiscounected async => (await isConnected) == false;
}
