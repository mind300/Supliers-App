import 'content.dart';

class BranchDetailsModel {
  Content? content;
  bool? success;
  String? message;
  int? status;

  BranchDetailsModel({
    this.content,
    this.success,
    this.message,
    this.status,
  });

  factory BranchDetailsModel.fromJson(Map<String, dynamic> json) {
    return BranchDetailsModel(
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
