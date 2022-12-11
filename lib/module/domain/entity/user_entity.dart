// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
  });

  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String city;

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phoneNumber,
      address,
      city,
    ];
  }

  @override
  bool get stringify => true;
}
