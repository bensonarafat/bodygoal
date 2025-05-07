import 'package:json_annotation/json_annotation.dart';
part 'onboarding.g.dart';

@JsonSerializable()
class Onboarding {
  final int id;
  final String description;
  final String url;
  final String action;

  Onboarding(
      {required this.id,
      required this.description,
      required this.url,
      required this.action});

  factory Onboarding.fromJson(Map<String, dynamic> json) =>
      _$OnboardingFromJson(json);

  Map<String, dynamic> toJson() => _$OnboardingToJson(this);
}
