// ignore_for_file: library_private_types_in_public_api

import 'package:bodygoal/main.dart';
import 'package:bodygoal/styles/colors.dart';
import 'package:flutter/material.dart';

export 'colors.dart';

@immutable
class AppStyle {
  late final double scale;

  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Rounded edge corner radiu
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  /// Padding and margin values
  late final _Insets insets = _Insets(scale);

  /// text styles
  late final _Text text = _Text(scale);

  /// Animation Durations
  final _Times times = _Times();

  /// Shared sizes
  late final _Sizes sizes = _Sizes();

  AppStyle({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
      return;
    }

    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    if (shortestSide > tabletXl) {
      scale = 1.2;
    } else if (shortestSide > tabletLg) {
      scale = 1.1;
    } else {
      scale = 1;
    }
  }
}

@immutable
class _Text {
  final double _scale;
  _Text(this._scale);

  final Map<String, TextStyle> _titleFonts = {
    'en': const TextStyle(fontFamily: "Lato"),
  };

  final Map<String, TextStyle> _monoTitleFonts = {
    'en': const TextStyle(fontFamily: 'Lato'),
  };

  final Map<String, TextStyle> _quoteFonts = {
    'en': const TextStyle(fontFamily: 'Lato'),
    'zh': const TextStyle(fontFamily: 'Lato'),
  };

  final Map<String, TextStyle> _tempusTitleFonts = {
    'en': const TextStyle(fontFamily: "Lato"),
  };

  final Map<String, TextStyle> _contentFonts = {
    'en': const TextStyle(fontFamily: 'Lato', fontFeatures: [
      FontFeature.enable('kern'),
    ]),
  };

  TextStyle _getFontForLocale(Map<String, TextStyle> fonts) {
    if (localeLogic.isLoaded) {
      return fonts.entries
          .firstWhere((x) => x.key == $strings.localeName,
              orElse: () => fonts.entries.first)
          .value;
    } else {
      return fonts.entries.first.value;
    }
  }

  TextStyle get titleFont => _getFontForLocale(_titleFonts);
  TextStyle get quoteFont => _getFontForLocale(_quoteFonts);
  TextStyle get tempusTitleFont => _getFontForLocale(_tempusTitleFonts);
  TextStyle get contentFont => _getFontForLocale(_contentFonts);
  TextStyle get monoTitleFont => _getFontForLocale(_monoTitleFonts);

  late final TextStyle dropCase =
      _createFont(quoteFont, sizePx: 56, heightPx: 20);

  late final TextStyle tempusTitle =
      _createFont(tempusTitleFont, sizePx: 64, heightPx: 56);

  late final TextStyle h1 = _createFont(titleFont, sizePx: 64, heightPx: 62);
  late final TextStyle h2 = _createFont(titleFont, sizePx: 32, heightPx: 46);
  late final TextStyle h3 =
      _createFont(titleFont, sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late final TextStyle h4 =
      _createFont(titleFont, sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  late final TextStyle title1 =
      _createFont(titleFont, sizePx: 16, heightPx: 26, spacePc: 5);
  late final TextStyle title2 =
      _createFont(titleFont, sizePx: 14, heightPx: 16.28);

  late final TextStyle body =
      _createFont(contentFont, sizePx: 16, heightPx: 26);
  late final TextStyle bodyBold = _createFont(contentFont,
      sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  late final TextStyle bodySmall =
      _createFont(contentFont, sizePx: 14, heightPx: 23);
  late final TextStyle bodySmallBold = _createFont(contentFont,
      sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  late final TextStyle quote1 = _createFont(quoteFont,
      sizePx: 32, heightPx: 40, weight: FontWeight.w600, spacePc: -3);
  late final TextStyle quote2 =
      _createFont(quoteFont, sizePx: 21, heightPx: 32, weight: FontWeight.w400);
  late final TextStyle quote2Sub =
      _createFont(body, sizePx: 16, heightPx: 40, weight: FontWeight.w600);

  late final TextStyle caption = _createFont(contentFont,
          sizePx: 14, heightPx: 20, weight: FontWeight.w500)
      .copyWith(fontStyle: FontStyle.italic);

  late final TextStyle callout = _createFont(contentFont,
          sizePx: 16, heightPx: 26, weight: FontWeight.w600)
      .copyWith(fontStyle: FontStyle.italic);
  late final TextStyle btn = _createFont(contentFont,
      sizePx: 14, weight: FontWeight.w500, spacePc: 2, heightPx: 14);

  TextStyle _createFont(TextStyle style,
      {required double sizePx,
      double? heightPx,
      double? spacePc,
      FontWeight? weight}) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }
    return style.copyWith(
        fontSize: sizePx,
        height: heightPx != null ? (heightPx / sizePx) : style.height,
        letterSpacing:
            spacePc != null ? sizePx * spacePc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 20;
  late final double md = 32;
  late final double lg = 50;
  late final double xl = 0;
  late final double xxl = 0;
  late final double offset = 0;
}

class _Sizes {
  double get maxContentWidth1 => 800;
  double get maxContentWidth2 => 600;
  double get maxContentWidth3 => 500;
  final Size minAppSize = const Size(380, 650);
}

@immutable
class _Insets {
  final double _scale;
  _Insets(this._scale);

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
        color: Colors.black.withOpacity(.25),
        offset: const Offset(0, 2),
        blurRadius: 4),
  ];
  final text = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 2),
        blurRadius: 2),
  ];

  final textStrong = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 4),
        blurRadius: 6),
  ];
}
