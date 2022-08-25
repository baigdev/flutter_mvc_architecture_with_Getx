import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

@JsonSerializable(genericArgumentFactories: true)
class SingleResponse<T> extends BaseResponse {
  T? data;

  SingleResponse({
    dynamic message,
    bool? success,
    int? code,
    this.data,
  }) : super(message: message, success: success, code: code);

  factory SingleResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return SingleResponse<T>(
        success: json["success"],
        message: json["message"],
        code: json['code'],
        data: create(json["data"] ?? []));
  }
}
