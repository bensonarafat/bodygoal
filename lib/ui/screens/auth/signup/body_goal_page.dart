import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BodyGoalPage extends StatefulWidget {
  final VoidCallback onNext;
  const BodyGoalPage({
    super.key,
    required this.onNext,
  });

  @override
  State<BodyGoalPage> createState() => _BodyGoalPageState();
}

class _BodyGoalPageState extends State<BodyGoalPage> {
  List<Map<String, dynamic>> bodySizes = [
    {
      "url": "assets/images/lose_weight.png",
      "title": "Lose weight",
    },
    {
      "url": "assets/images/get_shredded.png",
      "title": "Get Shredded",
    },
    {
      "url": "assets/images/get_shredded.png",
      "title": "Get Shredded",
    },
    {
      "url": "assets/images/build_muscle.png",
      "title": "Build Muscle",
    },
    {
      "url": "assets/images/keep_fit.png",
      "title": "Keep Fit",
    },
  ];

  int selected = -1;
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
                "What is your \n Body Goal?",
                style: $styles.text.h2.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
              const Gap(20),
              Column(
                  children: List.generate(bodySizes.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: Container(
                      height: 86,
                      margin: const EdgeInsets.only(bottom: 12),
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1B1B1B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: selected == index
                                ? $styles.colors.accent1
                                : $styles.colors.transparent,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              bodySizes[index]["title"],
                              style: $styles.text.title2.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Transform.scale(
                                scale: 2,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  bodySizes[index]["url"],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              })),
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
