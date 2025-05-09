import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/common/utils/app_bar.dart';
import 'package:bodygoal/ui/screens/auth/signup/body_goal_page.dart';
import 'package:bodygoal/ui/screens/auth/signup/body_focus_page.dart';
import 'package:bodygoal/ui/screens/auth/signup/focus_page.dart';
import 'package:bodygoal/ui/screens/auth/signup/gender_page.dart';
import 'package:bodygoal/ui/screens/auth/signup/motivation_page.dart';
import 'package:bodygoal/ui/screens/auth/signup/previous_attempts_page.dart';
import 'package:flutter/material.dart';

class SignupPartOneA extends StatefulWidget {
  const SignupPartOneA({super.key});

  @override
  State<SignupPartOneA> createState() => _SignupPartOneAState();
}

class _SignupPartOneAState extends State<SignupPartOneA> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    pageController.addListener(() => {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BodyGoalCustomAppBar(
        backgroundColor: $styles.colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16),
            child: Row(
              children: List.generate(
                  6,
                  (index) => Container(
                        margin: const EdgeInsets.all(2),
                        width: 21,
                        height: 3,
                        decoration: ShapeDecoration(
                          color: index == currentPage
                              ? const Color(0xFFBBF246)
                              : $styles.colors.greyMedium,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      )),
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                GenderPage(
                  onNext: () {
                    goToNext();
                  },
                ),
                BodyGoalPage(
                  onNext: () {
                    goToNext();
                  },
                ),
                BodyFocusPage(
                  onNext: () {
                    goToNext();
                  },
                ),
                FocusPage(
                  onNext: () {
                    goToNext();
                  },
                ),
                MotivationPage(
                  onNext: () {
                    goToNext();
                  },
                ),
                PreviousAttemptsPage(
                  onNext: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void goToNext() {
    setState(() {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
      currentPage = (pageController.page?.toInt() ?? 0) + 1;
    });
  }
}
