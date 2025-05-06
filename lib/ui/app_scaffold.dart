import 'package:bodygoal/logic/common/app_scroll_bahavior.dart';
import 'package:bodygoal/main.dart';
import 'package:bodygoal/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sized_context/sized_context.dart';

class BodyGoalScaffold extends StatelessWidget {
  const BodyGoalScaffold({super.key, required this.child});
  final Widget child;
  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    // Listen to the device size, and update AppStyle when  it changes
    final mq = MediaQuery.of(context);
    appLogic.handleAppSizeChanged(mq.size);
    // Set default timing for animations in the app
    Animate.defaultDuration = _style.times.fast;
    // Create a style object that will be passed down the widget tree
    _style = AppStyle(screenSize: context.sizePx);
    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: DefaultTextStyle(
        style: $styles.text.body,
        // use a custom scroll behavior across entrie app
        child: ScrollConfiguration(
          behavior: AppScrollBehavior(),
          child: child,
        ),
      ),
    );
  }
}
