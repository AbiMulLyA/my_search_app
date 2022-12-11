import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel extends Equatable {
  const ResponseModel({
    required this.success,
    required this.code,
    required this.message,
    this.dataTotal,
  });

  final bool success;
  final int code;
  final String message;
  @JsonKey(name: 'data_total')
  final int? dataTotal;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  List<Object> get props => [success, code, message];

  @override
  bool get stringify => true;
}
