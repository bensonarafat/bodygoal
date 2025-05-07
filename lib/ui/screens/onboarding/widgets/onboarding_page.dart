import 'package:avatar_glow/avatar_glow.dart';
import 'package:bodygoal/data/models/onboarding.dart';
import 'package:bodygoal/main.dart';
import 'package:bodygoal/ui/screens/onboarding/widgets/circular_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class OnboardingPage extends StatefulWidget {
  final Onboarding data;
  final int len;
  final int currentIndex;
  final Function onComplete;
  const OnboardingPage({
    super.key,
    required this.data,
    required this.len,
    required this.currentIndex,
    required this.onComplete,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  final _timerKey = GlobalKey<CircularTimerState>();
  int _videoDurationInSeconds = 0;
  bool _isInitialized = false;
  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.data.url,
        videoPlayerOptions: VideoPlayerOptions())
      ..initialize().then((_) {
        _videoDurationInSeconds = _controller.value.duration.inSeconds;
        _controller.addListener(_videoListener);
        setState(() {
          _controller.play();
          _isInitialized = true;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);

    _controller.dispose();
    super.dispose();
  }

  void _videoListener() {
    // If video is playing, make sure timer is running
    if (_controller.value.isPlaying) {
      // Check if timer isn't already running
      if (_timerKey.currentState != null &&
          !_timerKey.currentState!.isRunning) {
        // Start the timer from current position
        final progress =
            _controller.value.position.inSeconds / _videoDurationInSeconds;
        _timerKey.currentState!.animationController.value = progress;
        _timerKey.currentState!.start();
      }
    } else {
      // If video is paused, pause the timer
      if (_timerKey.currentState != null && _timerKey.currentState!.isRunning) {
        _timerKey.currentState!.pause();
      }
    }
  }

  void _playPauseVideo() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _timerKey.currentState?.pause();
      } else {
        _controller.play();
        _timerKey.currentState?.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const CupertinoActivityIndicator();
    }
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(),
        ),
        GestureDetector(
          onTap: _playPauseVideo,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.01, 9],
                colors: [
                  $styles.colors.transparent,
                  $styles.colors.black,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 50,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CircularTimer(
                  key: _timerKey,
                  duration: _videoDurationInSeconds,
                  size: 400,
                  backgroundColor: $styles.colors.black,
                  progressColor: $styles.colors.accent1,
                  strokeWidth: 3.0,
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: $styles.colors.white,
                  ),
                  onComplete: () {
                    widget.onComplete.call();
                  }),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              padding: EdgeInsets.all($styles.insets.sm),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.len,
                          (index) =>
                              _buildPageIndicator(index == widget.currentIndex),
                        ),
                      ),
                      const Gap(9),
                      Text(
                        widget.data.description,
                        textAlign: TextAlign.center,
                        style: $styles.text.h3
                            .copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const Gap(80),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.data.action,
                          textAlign: TextAlign.end,
                          style: $styles.text.btn.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AvatarGlow(
                          child: Material(
                            elevation: 5.0,
                            shape: const CircleBorder(),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[800],
                              radius: 30,
                              child: Icon(
                                CupertinoIcons.arrow_right,
                                color: $styles.colors.accent1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color:
            isActive ? $styles.colors.accent1 : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
