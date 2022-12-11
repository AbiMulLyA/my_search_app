import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String city,
  }) : super(
          id: id,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          city: city,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
