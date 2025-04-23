import 'error.dart';

class ErrorModel {
  int? code;
  String? message;
  List<Error>? errors;
  List<dynamic>? data;

  ErrorModel({this.code, this.message, this.errors, this.data});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        code: json['code'] as int?,
        message: json['message'] as String?,
        errors: (json['errors'] as List<dynamic>?)
            ?.map((e) => Error.fromJson(e as Map<String, dynamic>))
            .toList(),
        data: json['data'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'errors': errors?.map((e) => e.toJson()).toList(),
        'data': data,
      };
}
