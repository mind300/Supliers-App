import 'branch.dart';

class Content {
  int? id;
  String? name;
  String? email;
  String? type;
  int? jobId;
  String? mobileNumber;
  int? isActive;
  String? image;
  String? createdAt;
  List<Branch>? branches;

  Content({
    this.id,
    this.name,
    this.email,
    this.type,
    this.jobId,
    this.mobileNumber,
    this.isActive,
    this.image,
    this.createdAt,
    this.branches,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        type: json['type'] as String?,
        jobId: json['job_id'] as int?,
        mobileNumber: json['mobile_number'] as String?,
        isActive: json['is_active'] as int?,
        image: json['image'] as String?,
        createdAt: json['created_at'] as String?,
        branches: (json['branches'] as List<dynamic>?)?.map((e) => Branch.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'type': type,
        'job_id': jobId,
        'mobile_number': mobileNumber,
        'is_active': isActive,
        'image': image,
        'created_at': createdAt,
        'branches': branches?.map((e) => e.toJson()).toList(),
      };
}
