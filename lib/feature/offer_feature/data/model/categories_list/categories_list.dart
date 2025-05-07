import 'content.dart';

class CategoriesList {
  List<Content>? content;
  bool? success;
  String? message;
  int? status;

  CategoriesList({this.content, this.success, this.message, this.status});

  factory CategoriesList.fromJson(Map<String, dynamic> json) {
    return CategoriesList(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content?.map((e) => e.toJson()).toList(),
        'success': success,
        'message': message,
        'status': status,
      };
}
