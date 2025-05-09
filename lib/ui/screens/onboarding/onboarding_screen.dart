import 'package:bodygoal/data/models/onboarding.dart';
import 'package:bodygoal/ui/screens/onboarding/provider/onboarding_provider.dart';
import 'package:bodygoal/ui/screens/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OnboardingProvider>(context, listen: false).fetchData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingProvider>(builder: (context, provider, _) {
        if (provider.isLoading && provider.data.isEmpty) {
          return const CupertinoActivityIndicator();
        }
        List<Onboarding> data = provider.data;
        return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                data: data[index],
                len: data.length,
                currentIndex: index,
                onComplete: () {
                  if (index < data.length - 1) {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
              );
            });
      }),
    );
  }
}
