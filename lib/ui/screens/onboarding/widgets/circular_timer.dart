import 'dart:math';

import 'package:flutter/material.dart';

class CircularTimer extends StatefulWidget {
  final int duration;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;
  final TextStyle textStyle;
  final VoidCallback? onComplete;
  final bool countDown;
  const CircularTimer(
      {super.key,
      required this.duration,
      this.size = 200.0,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.blue,
      this.strokeWidth = 10.0,
      this.textStyle =
          const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      this.onComplete,
      this.countDown = true});

  @override
  State<CircularTimer> createState() => CircularTimerState();
}

class CircularTimerState extends State<CircularTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;
  int _secondsRemaining = 0;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.countDown ? widget.duration : 0;

    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.duration));

    _animation = Tween<double>(
      begin: widget.countDown ? 1.0 : 0.0,
      end: widget.countDown ? 0.0 : 1.0,
    ).animate(animationController);

    animationController.addListener(() {
      setState(() {
        if (widget.countDown) {
          _secondsRemaining =
              (widget.duration * (1 - animationController.value)).round();
        } else {
          _secondsRemaining =
              (widget.duration * animationController.value).round();
        }
      });
    });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isRunning = false;
        });

        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      }
    });

    start();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void start() {
    if (animationController.isCompleted) {
      reset();
    }

    setState(() {
      isRunning = true;
    });

    animationController.forward(from: animationController.value);
  }

  void pause() {
    setState(() {
      isRunning = false;
    });
    animationController.stop();
  }

  void reset() {
    setState(() {
      isRunning = false;
      _secondsRemaining = widget.countDown ? widget.duration : 0;
    });
    animationController.reset();
  }

  void toggletimer() {
    if (isRunning) {
      pause();
    } else {
      start();
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int reminingSeconds = seconds % 60;
    return '$minutes:${reminingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: CircularTimerPainter(
                    progress: 1.0,
                    color: widget.backgroundColor,
                    strokeWidth: widget.strokeWidth),
              ),
              // Progress arc
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: CircularTimerPainter(
                    progress: _animation.value,
                    color: widget.progressColor,
                    strokeWidth: widget.strokeWidth),
              ),
              // Time text
              Text(
                _formatTime(_secondsRemaining),
                style: widget.textStyle,
              )
            ],
          ),
        );
      },
    );
  }
}

class CircularTimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CircularTimerPainter(
      {super.repaint,
      required this.progress,
      required this.color,
      required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the arc from top (270 degree) clockwise
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * progress, false, paint);
  }

  @override
  bool shouldRepaint(CircularTimerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
