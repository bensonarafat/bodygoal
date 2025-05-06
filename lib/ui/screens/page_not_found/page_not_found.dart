import 'package:bodygoal/main.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  final String url;
  const PageNotFound(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    // void handleHomePressed() => context.go(ScreenPaths.home);
    return Scaffold(
      backgroundColor: $styles.colors.black,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
