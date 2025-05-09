import 'package:bodygoal/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BodyGoalAppBarWithBack extends AppBar {
  final BuildContext context;
  final Text? titleWidget;
  final Color? bgColor;
  final double height;
  final bool? center;

  BodyGoalAppBarWithBack(
    this.context, {
    super.key,
    this.titleWidget,
    this.bgColor,
    this.center,
    this.height = kToolbarHeight,
  }) : super(
            title: titleWidget,
            backgroundColor: bgColor ?? $styles.colors.black,
            centerTitle: center,
            leading: Padding(
              padding: EdgeInsets.all($styles.insets.xxs),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: $styles.colors.greyStrong,
                ),
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: $styles.colors.offWhite,
                  ),
                ),
              ),
            ));

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class BodyGoalCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final Widget? leading;
  final bool showLeading;
  final double fontSize;
  const BodyGoalCustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 2.0,
    this.leading,
    this.showLeading = true,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: $styles.colors.black.withOpacity(0.1),
                  blurRadius: elevation,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
          child: Container(
        height: kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
        child: Row(
          mainAxisAlignment: centerTitle
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            if (showLeading) ...{
              if (leading != null) ...{
                leading!
              } else if (Navigator.canPop(context)) ...{
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.chevron_left,
                      color: titleColor ?? $styles.colors.offWhite),
                ),
              },
            } else ...{
              const Expanded(
                child: SizedBox(),
              ),
            },
            if (centerTitle) const Spacer(),
            if (title != null) ...{
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all($styles.insets.xs),
                  child: title,
                ),
              )
            },
            if (centerTitle) const Spacer(),
            if (actions != null) ...{
              Row(
                children: actions!,
              ),
            } else ...{
              const Expanded(
                child: SizedBox(),
              ),
            }
          ],
        ),
      )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
