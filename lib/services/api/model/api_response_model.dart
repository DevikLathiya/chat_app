import 'dart:convert';

class ApiResponseModel<T> {
  final String? responseCode;
  final int statusCode;
  final String messageText;
  final bool? success;
  T? responseData;

  ApiResponseModel({
    this.responseCode,
    required this.messageText,
    this.responseData,
    this.success,
    required this.statusCode,
  });

  ApiResponseModel copyWith({
    String? responseCode,
    int? statusCode,
    String? responseText,
    bool? success,
    T? responseData,
  }) =>
      ApiResponseModel(
        responseCode: responseCode ?? this.responseCode,
        statusCode: statusCode ?? this.statusCode,
        messageText: responseText ?? this.messageText,
        success: success ?? this.success,
        responseData: responseData ?? this.responseData,
      );

  String toRawJson() => json.encode(toJson());

  factory ApiResponseModel.fromJson(Map<String, dynamic> json, int? statusCode) => ApiResponseModel(
        responseCode: json["ResponseCode"].toString(),
        messageText: json["message"],
        responseData: json["data"],
        success: json["success"],
        statusCode: statusCode ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "message": messageText,
        "data": responseData,
        "success": success,
        "status": statusCode,
      };
}
