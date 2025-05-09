import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/common/controls/buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum CurveType { none, upward, downward }

class BodyFocusPage extends StatefulWidget {
  final VoidCallback onNext;
  const BodyFocusPage({
    super.key,
    required this.onNext,
  });

  @override
  State<BodyFocusPage> createState() => _BodyFocusPageState();
}

class _BodyFocusPageState extends State<BodyFocusPage> {
  Set<String> selectedBodyParts = {};

  // Body parts with their corresponding positions
  final List<Map<String, dynamic>> bodyParts = [
    {
      'name': 'Shoulder',
      'position': 0.15,
      'curve': CurveType.downward,
      'curveStrength': 0.5,
    },
    {
      'name': 'Chest',
      'position': 0.30,
      'curve': CurveType.none,
    },
    {
      'name': 'Arm',
      'position': 0.38,
      'curve': CurveType.none,
    },
    {
      'name': 'Back',
      'position': 0.46,
      'curve': CurveType.upward,
      'curveStrength': 0.4,
    },
    {
      'name': 'Leg',
      'position': 0.60,
      'curve': CurveType.none,
    },
  ];

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
                "What's your \n Focus Area?",
                style: $styles.text.h2.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: 450,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Image.asset(
                        'assets/images/male.png',
                      ),
                    ),
                    ...bodyParts.map((part) => _buildBodyPartLabel(part)),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedBodyParts.isEmpty) {
                              selectedBodyParts.addAll(
                                  ["Shoulder", "Chest", "Arm", "Back", "Leg"]);
                            } else {
                              selectedBodyParts.clear();
                            }
                          });
                        },
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  selectedBodyParts.length == bodyParts.length
                                      ? $styles.colors.accent1
                                      : $styles.colors.black,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white30,
                              ),
                            ),
                            child: Text(
                              'Full Body',
                              style: TextStyle(
                                color:
                                    selectedBodyParts.length == bodyParts.length
                                        ? Colors.black
                                        : Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildBodyPartLabel(Map<String, dynamic> bodyPart) {
    final double heightPosition = bodyPart['position'];
    final CurveType curveType = bodyPart['curve'] ?? CurveType.none;
    final double curveStrength = bodyPart['curveStrength'] ?? 0.3;

    return Positioned(
      top: (MediaQuery.of(context).size.height / 1.8) * heightPosition,
      right: 30,
      left: MediaQuery.of(context).size.width * 0.3,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (selectedBodyParts.contains(bodyPart['name'])) {
              selectedBodyParts.remove(bodyPart['name']);
            } else {
              selectedBodyParts.add(bodyPart['name']);
            }
          });
        },
        child: Row(
          children: [
            // Dotted line
            Expanded(
              child: CustomPaint(
                painter: DottedLinePainter(
                  color: selectedBodyParts.contains(bodyPart['name'])
                      ? $styles.colors.accent1
                      : Colors.white38,
                  curveType: curveType,
                  curveStrength: curveStrength,
                ),
                child: const SizedBox(height: 2),
              ),
            ),

            // Body part label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: selectedBodyParts.contains(bodyPart['name'])
                    ? $styles.colors.accent1
                    : Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                bodyPart['name'],
                style: TextStyle(
                  color: selectedBodyParts.contains(bodyPart['name'])
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final CurveType curveType;
  final double curveStrength;

  DottedLinePainter({
    required this.color,
    this.curveType = CurveType.none,
    this.curveStrength = 0.3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Create path based on curve type
    final path = Path();
    path.moveTo(0, size.height / 2);

    if (curveType == CurveType.none) {
      // Straight line
      path.lineTo(size.width, size.height / 2);
    } else {
      // Define control point for quadratic curve
      final double controlPointX = size.width / 2;
      final double controlPointY = curveType == CurveType.upward
          ? size.height / 2 - (size.height * curveStrength)
          : size.height / 2 + (size.height * curveStrength);

      // Create quadratic bezier curve
      path.quadraticBezierTo(
          controlPointX, controlPointY, size.width, size.height / 2);
    }

    // Draw the dotted path
    const dashWidth = 3.0;
    const dashSpace = 5.0;
    final pathMetrics = path.computeMetrics().first;
    final pathLength = pathMetrics.length;

    double distance = 0.0;
    bool drawDash = true;

    while (distance < pathLength) {
      final double dashDistance = drawDash ? dashWidth : dashSpace;

      if (drawDash) {
        final start = pathMetrics.getTangentForOffset(distance);
        final end = pathMetrics
            .getTangentForOffset((distance + dashWidth).clamp(0, pathLength));

        if (start != null && end != null) {
          canvas.drawLine(start.position, end.position, paint);
        }
      }

      distance += dashDistance;
      drawDash = !drawDash;
    }
  }

  @override
  bool shouldRepaint(DottedLinePainter oldDelegate) =>
      color != oldDelegate.color ||
      curveType != oldDelegate.curveType ||
      curveStrength != oldDelegate.curveStrength;
}
