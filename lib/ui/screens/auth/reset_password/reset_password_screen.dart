import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:bodygoal/ui/common/utils/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Create 6 text controllers for a 6-digit OTP
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // Create 6 focus nodes
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  // Store the OTP
  String get _otp => _controllers.map((controller) => controller.text).join();

  @override
  void dispose() {
    // Clean up controllers and focus nodes
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

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
              "Reset Password",
              style: $styles.text.h2.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 34,
              ),
            ),
            const Gap(14),
            Text(
              "A six digit code has been sent to your email address",
              style: $styles.text.body.copyWith(
                fontSize: 12,
                color: const Color(0xFFC4C4C4),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(81),
            Row(
              children: List.generate(
                6,
                (index) => Expanded(
                  child: Container(
                    margin: EdgeInsets.all($styles.insets.xxs),
                    height: 61.59,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 56, 26, 26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _controllers[index],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        focusNode: _focusNodes[index],
                        onChanged: (value) {
                          // When a digit is entered, move focus to the next field
                          if (value.isNotEmpty) {
                            if (index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              // Last digit entered, hide keyboard
                              _focusNodes[index].unfocus();
                            }
                          }
                        },
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: $styles.text.body.copyWith(
                          fontSize: 25.98,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Color(0xFF1B1B1B),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't receive your code?",
                  style: $styles.text.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(4),
                Text(
                  "Resend",
                  style: $styles.text.body.copyWith(
                    color: $styles.colors.accent1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Gap(46),
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
          ],
        ),
      ),
    );
  }
}
