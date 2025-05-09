import 'package:bodygoal/main.dart';
import 'package:bodygoal/router.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:bodygoal/ui/common/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BodyGoalCustomAppBar(
          showLeading: false,
          title: Image.asset("assets/images/_common/logo.png"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(86),
                Text(
                  "Sign Into Your BodyGoal Account",
                  style: $styles.text.h2.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 34,
                  ),
                ),
                const Gap(62),
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
                        hintText: "Username Or Email",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B1B1B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF1B1B1B),
                        hintText: "Password",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () => context.push(ScreenPaths.forgotPassword),
                  child: Text(
                    "Forgot Password",
                    style: $styles.text.body.copyWith(
                      color: $styles.colors.accent1,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Gap(58),
                AppBtn(
                  bgColor: $styles.colors.accent1,
                  borderRadius: 30.0,
                  minimumSize: const Size(double.infinity, 0),
                  onPressed: () {},
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
                  onTap: () => context.push(ScreenPaths.register),
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
        ));
  }
}
