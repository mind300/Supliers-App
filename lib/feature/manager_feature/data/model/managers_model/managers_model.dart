import 'package:supplies/feature/branch_feature/data/model/pagination.dart';

import 'content.dart';

class ManagersModel {
  List<Content>? content;
  bool? success;
  String? message;
  int? status;
  Pagination? pagination;

  ManagersModel({
    this.content,
    this.success,
    this.message,
    this.status,
    this.pagination,
  });

  factory ManagersModel.fromJson(Map<String, dynamic> json) => ManagersModel(
        content: (json['content'] as List<dynamic>?)
            ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
            .toList(),
        success: json['success'] as bool?,
        message: json['message'] as String?,
        status: json['status'] as int?,
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'content': content?.map((e) => e.toJson()).toList(),
        'success': success,
        'message': message,
        'status': status,
        'pagination': pagination?.toJson(),
      };
}
