import 'content.dart';

class MyProfileModel {
  Content? content;
  bool? success;
  String? message;
  int? status;

  MyProfileModel({this.content, this.success, this.message, this.status});

  factory MyProfileModel.fromJson(Map<String, dynamic> json) {
    return MyProfileModel(
      content: json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content?.toJson(),
        'success': success,
        'message': message,
        'status': status,
      };
}
