import 'package:supplies/feature/branch_feature/data/model/pagination.dart';

import 'content.dart';

class BranchListModel {
  List<Content>? content;
  bool? success;
  String? message;
  int? status;

  BranchListModel({
    this.content,
    this.success,
    this.message,
    this.status,
  });

  factory BranchListModel.fromJson(Map<String, dynamic> json) {
    return BranchListModel(
      content: (json['content'] as List<dynamic>?)?.map((e) => Content.fromJson(e as Map<String, dynamic>)).toList(),
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
