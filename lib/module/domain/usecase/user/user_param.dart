// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_param.g.dart';

@JsonSerializable()
class UserParam extends Equatable {
  const UserParam({
    this.name,
    this.email,
    this.city,
    this.address,
    this.phoneNumber,
  });

  final String? name;
  final String? email;
  final String? city;
  final String? address;
  final String? phoneNumber;

  factory UserParam.fromJson(Map<String, dynamic> json) =>
      _$UserParamFromJson(json);
  Map<String, dynamic> toJson() => _$UserParamToJson(this);

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}
