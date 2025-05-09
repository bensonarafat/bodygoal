import 'package:bodygoal/main.dart';
import 'package:bodygoal/router.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:bodygoal/ui/common/utils/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class StartedScreen extends StatelessWidget {
  const StartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BodyGoalCustomAppBar(
        backgroundColor: $styles.colors.transparent,
        elevation: 0,
        actions: [
          Container(
            width: 72,
            height: 29,
            decoration: ShapeDecoration(
              color: const Color(0xFF1B1B1B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.18),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 33,
                  child: Text(
                    ' ENG',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.85,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_down,
                  size: 15,
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50),
                  Text(
                    "Get Started",
                    style: $styles.text.h2.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 34,
                    ),
                  ),
                  const Gap(46),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B1B1B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF1B1B1B),
                          hintText: "What's Your Name?",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppBtn(
                      bgColor: $styles.colors.accent1,
                      borderRadius: 30.0,
                      minimumSize: const Size(double.infinity, 0),
                      onPressed: () => context.push(ScreenPaths.authmessage),
                      padding: EdgeInsets.symmetric(
                        horizontal: $styles.insets.sm,
                        vertical: $styles.insets.sm,
                      ),
                      semanticLabel: "Continue",
                      child: Text(
                        "Continue",
                        style: $styles.text.btn.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF1B1D1A),
                        ),
                      ),
                    ),
                    const Gap(24),
                    GestureDetector(
                      onTap: () => context.push(ScreenPaths.login),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style: $styles.text.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "Sign up",
                            style: $styles.text.body.copyWith(
                              color: $styles.colors.accent1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
