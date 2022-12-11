// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CityEntity extends Equatable {
  const CityEntity({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props {
    return [
      id,
      name,
    ];
  }

  @override
  bool get stringify => true;
}
