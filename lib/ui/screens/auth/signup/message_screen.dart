import 'package:bodygoal/router.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:bodygoal/ui/common/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BodyGoalCustomAppBar(
        backgroundColor: $styles.colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/user.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )),
                  Text(
                    "Hello Sensei",
                    style: $styles.text.h3.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    "Welcome to bodygoal",
                    style: $styles.text.h3.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    "My name is Marcus I am your personal coach. To help you achieve your fitness goals, we need to know a bit more about you. Here are some questions to create a personalized plan designed specifically for you.",
                    textAlign: TextAlign.center,
                    style: $styles.text.body.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 72),
                child: AppBtn(
                  bgColor: $styles.colors.accent1,
                  borderRadius: 30.0,
                  minimumSize: const Size(double.infinity, 0),
                  onPressed: () => context.push(ScreenPaths.titlepage),
                  padding: EdgeInsets.symmetric(
                    horizontal: $styles.insets.sm,
                    vertical: $styles.insets.sm,
                  ),
                  semanticLabel: "I'm Ready",
                  child: Text(
                    "I'm Ready",
                    style: $styles.text.btn.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color(0xFF1B1D1A),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
