import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

const List<String> focuses = [
  "Burn Fat",
  "Body Sculpting",
  "Strength",
  "Endurance",
  "Mental strength",
  "Build muscles"
];

class FocusPage extends StatefulWidget {
  final VoidCallback onNext;
  const FocusPage({
    super.key,
    required this.onNext,
  });

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  Set<String> selected = {};
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
                "Choose your \n Focus",
                style: $styles.text.h2.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
              const Gap(20),
              Wrap(
                children: List.generate(
                  focuses.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selected.contains(focuses[index])) {
                          selected.remove(focuses[index]);
                        } else {
                          selected.add(focuses[index]);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1B1B1B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: selected.contains(focuses[index])
                                ? $styles.colors.accent1
                                : $styles.colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        focuses[index],
                        style: $styles.text.body.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              )
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
