import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GenderPage extends StatefulWidget {
  final VoidCallback onNext;
  const GenderPage({super.key, required this.onNext});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String gender = "male";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.sm),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Text(
                "What's Your \n Gender",
                style: $styles.text.h2.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
              const Gap(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        gender = "male";
                      });
                    },
                    child: AnimatedOpacity(
                      opacity: gender == "male" ? 1 : 0.3,
                      duration: const Duration(milliseconds: 300),
                      child: Stack(alignment: Alignment.center, children: [
                        gender == "male"
                            ? AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 169,
                                height: 169,
                                decoration: BoxDecoration(
                                  color: $styles.colors.accent1,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : const SizedBox.shrink(),
                        AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: gender == "male" ? 1.0 : 0.85,
                          child: Image.asset(
                            "assets/images/male.png",
                            width: 130,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        gender = "female";
                      });
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: gender == "female" ? 1 : 0.3,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          gender == "female"
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 169,
                                  height: 169,
                                  decoration: BoxDecoration(
                                    color: $styles.colors.accent1,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          AnimatedScale(
                            duration: const Duration(milliseconds: 300),
                            scale: gender == "female" ? 1.0 : 0.85,
                            child: Image.asset(
                              "assets/images/female.png",
                              width: 130,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: gender == "male"
                        ? Text(
                            "Male",
                            textAlign: TextAlign.center,
                            style: $styles.text.body.copyWith(
                              color: $styles.colors.accent1,
                            ),
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    child: gender == "female"
                        ? Text(
                            "Female",
                            textAlign: TextAlign.center,
                            style: $styles.text.body
                                .copyWith(color: $styles.colors.accent1),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 32),
              child: AppBtn(
                bgColor: $styles.colors.accent1,
                borderRadius: 30.0,
                minimumSize: const Size(double.infinity, 0),
                onPressed: () => widget.onNext.call(),
                padding: EdgeInsets.symmetric(
                  horizontal: $styles.insets.sm,
                  vertical: $styles.insets.sm,
                ),
                semanticLabel: "Next",
                child: Text(
                  "Next",
                  style: $styles.text.btn.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: const Color(0xFF1B1D1A),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
