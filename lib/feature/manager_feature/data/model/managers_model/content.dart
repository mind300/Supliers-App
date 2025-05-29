class Content {
  int? id;
  dynamic name;
  String? email;
  dynamic code;
  String? branchId;
  String? jobId;
  int? isActive;
  String? images;
  String? createdAt;

  Content({
    this.id,
    this.name,
    this.email,
    this.code,
    this.branchId,
    this.jobId,
    this.isActive,
    this.images,
    this.createdAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as dynamic,
        email: json['email'] as String?,
        code: json['code'] as dynamic,
        branchId: json['branch_id'].toString(),
        jobId: json['job_id'].toString(),
        isActive: json['is_active'] as int?,
        images: json['image'] as String?,
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'code': code,
        'branch_id': branchId,
        'job_id': jobId,
        'is_active': isActive,
        'images': images,
        'created_at': createdAt,
      };
}
