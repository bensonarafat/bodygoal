// ignore_for_file: constant_identifier_names

import 'package:bodygoal/main.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double size;
  final Color? color;
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});

  @override
  Widget build(BuildContext context) {
    String i = icon.name.toLowerCase().replaceAll('_', '-');
    String path = 'assets/images/_common/icons/icon-$i.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(
          path,
          width: size,
          height: size,
          color: color ?? $styles.colors.offWhite,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

enum AppIcons {
  close,
  close_large,
  collection,
  download,
  expand,
  fullscreen,
  fullscreen_exit,
  info,
  menu,
  next_large,
  north,
  prev,
  reset_location,
  search,
  share_android,
  share_ios,
  timeline,
  wallpaper,
  zoom_in,
  zoom_out,
}
