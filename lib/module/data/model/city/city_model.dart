import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/city_entity.dart';

part 'city_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CityModel extends CityEntity {
  const CityModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
