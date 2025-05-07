import 'package:bodygoal/data/models/onboarding.dart';
import 'package:bodygoal/data/repositories/onboarding_repository.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingRepository onboardingRepository;

  OnboardingProvider(this.onboardingRepository);

  bool _isLoading = true;
  List<Onboarding> _data = [];

  List<Onboarding> get data => _data;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    List<Onboarding> data = await onboardingRepository.data();
    _data = data;
    _isLoading = false;
    notifyListeners();
  }
}
