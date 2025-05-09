import 'package:bodygoal/main.dart';
import 'package:bodygoal/router.dart';
import 'package:bodygoal/ui/screens/onboarding/widgets/circular_timer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 5,
              top: kToolbarHeight,
              child: CircularTimer(
                duration: 2, // 2 seconds
                size: 50,
                backgroundColor: $styles.colors.black,
                progressColor: $styles.colors.accent1,
                strokeWidth: 3.0,
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: $styles.colors.white,
                ),
                onComplete: () {
                  context.replace(ScreenPaths.signupPartOneA);
                },
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Part 01",
                    style: $styles.text.h3.copyWith(
                      fontWeight: FontWeight.w400,
                      color: $styles.colors.accent1,
                    ),
                  ),
                  const Gap(6),
                  Text(
                    "Body Goal".toUpperCase(),
                    style: $styles.text.h3.copyWith(
                      fontWeight: FontWeight.w800,
                      color: $styles.colors.accent1,
                      fontSize: 36,
                    ),
                  ),
                  const Gap(6),
                  Container(
                      width: 264,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: $styles.colors.accent1,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
