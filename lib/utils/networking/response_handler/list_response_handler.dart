import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> extends BaseResponse {
  List<T>? data;

  ListResponse({
    dynamic message,
    bool? success,
    int? code,
    this.data,
  }) : super(message: message, success: success, code: code);

  factory ListResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    List<T> data = [];
    json['data'].forEach((v) {
      data.add(create(v));
    });

    return ListResponse<T>(
        success: json["success"],
        message: json["message"],
        code: json['code'],
        data: data);
  }
}
