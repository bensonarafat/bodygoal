import 'package:bodygoal/data/models/onboarding.dart';

abstract class OnboardingRepository {
  Future<List<Onboarding>> data();
}

class OnboardingRespositoryImpl implements OnboardingRepository {
  @override
  Future<List<Onboarding>> data() {
    return Future.value([
      Onboarding(
          id: 1,
          description: "AR-powered workouts and personalized plans!",
          url: "assets/videos/1.mp4",
          action: "Get Started"),
      Onboarding(
          id: 1,
          description: "Your goal, your plan, your pace",
          url: "assets/videos/2.mp4",
          action: "Get Started"),
      Onboarding(
          id: 1,
          description: "Personalized Meal plans and Intermittent fasting",
          url: "assets/videos/3.mp4",
          action: "Get Started"),
      Onboarding(
          id: 1,
          description:
              "Join the BUDI community, share progress, move, and earn rewards!",
          url: "assets/videos/4.mp4",
          action: "Get Started"),
    ]);
  }
}
