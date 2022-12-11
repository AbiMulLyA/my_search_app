// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserParam _$UserParamFromJson(Map<String, dynamic> json) => UserParam(
      name: json['name'] as String?,
      email: json['email'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$UserParamToJson(UserParam instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'city': instance.city,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
    };
