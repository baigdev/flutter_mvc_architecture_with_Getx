class BaseResponse {
  bool? success;
  int? code;
  String? message;

  BaseResponse({this.message, this.success, this.code});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
        success: json["success"],
        message: json["message"],
        code: json['code']);
  }
}
