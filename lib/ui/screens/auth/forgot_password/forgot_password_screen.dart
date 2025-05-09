import 'package:bodygoal/main.dart';
import 'package:bodygoal/router.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:bodygoal/ui/common/utils/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BodyGoalCustomAppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(CupertinoIcons.chevron_back)),
        title: Image.asset("assets/images/_common/logo.png"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(86),
            Text(
              "Forgot Password?",
              style: $styles.text.h2.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 34,
              ),
            ),
            const Gap(14),
            Text(
              "Please input your registered email address",
              style: $styles.text.body.copyWith(
                fontSize: 12,
                color: const Color(0xFFC4C4C4),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(81),
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
                    hintText: "Email Address",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
            const Gap(46),
            AppBtn(
              bgColor: $styles.colors.accent1,
              borderRadius: 30.0,
              minimumSize: const Size(double.infinity, 0),
              onPressed: () => context.push(ScreenPaths.resetPassword),
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
          ],
        ),
      ),
    );
  }
}
