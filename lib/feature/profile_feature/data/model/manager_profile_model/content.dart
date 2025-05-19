import '../../../../branch_feature/data/model/contant_branch_cashier.dart';
import 'package:supplies/feature/branch_feature/data/model/content.dart' as s;

class Content {
  int? id;
  String? name;
  String? email;
  int? code;
  List<s.Content>? branch;
  List<ContantBranchCashier>? branchCashier;
  dynamic manger;
  String? jobId;
  int? isActive;
  String? mobilePhone;
  String? images;
  String? createdAt;

  Content({
    this.id,
    this.name,
    this.email,
    this.mobilePhone,
    this.code,
    this.branch,
    this.branchCashier,
    this.jobId,
    this.manger,
    this.isActive,
    this.images,
    this.createdAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        code: json['code'] as int?,
        mobilePhone: json['mobile_number'] as String?,
        // branch: json['branch'] == null ? null : Branch.fromJson(json['branch'] as Map<String, dynamic>),
        branch: json['branches'] is List
            ? (json['branches'] as List<dynamic>?)
                ?.map((e) => s.Content.fromJson(e as Map<String, dynamic>))
                .toList()
            : [s.Content.fromJson(json['branches'] as Map<String, dynamic>)],
        branchCashier:
            (json['branch'] != null && json['branch'] is Map<String, dynamic>)
                ? [
                    ContantBranchCashier.fromJson(
                        json['branch'] as Map<String, dynamic>)
                  ]
                : [],
        jobId: json['job_id'].toString(),
        isActive: json['is_active'] as int?,
        manger: json['manager'],
        images: json['image'] as String?,
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile_phone': mobilePhone,
        'code': code,
        'branches': branch?.map((e) => e.toJson()).toList(),
        'job_id': jobId,
        'branch': branchCashier != null && branchCashier!.isNotEmpty
            ? branchCashier!.first.toJson()
            : null,
        'is_active': isActive,
        'images': images,
        'manager': manger,
        'created_at': createdAt,
      };
}
