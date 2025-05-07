// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Onboarding _$OnboardingFromJson(Map<String, dynamic> json) => Onboarding(
      id: (json['id'] as num).toInt(),
      description: json['description'] as String,
      url: json['url'] as String,
      action: json['action'] as String,
    );

Map<String, dynamic> _$OnboardingToJson(Onboarding instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'url': instance.url,
      'action': instance.action,
    };
