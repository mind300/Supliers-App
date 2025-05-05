class Cashier {
  int? id;
  String? name;
  String? email;
  int? code;
  int? branchId;
  String? jobId;
  int? isActive;
  String? createdAt;

  Cashier({
    this.id,
    this.name,
    this.email,
    this.code,
    this.branchId,
    this.jobId,
    this.isActive,
    this.createdAt,
  });

  factory Cashier.fromJson(Map<String, dynamic> json) => Cashier(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        code: json['code'] as int?,
        branchId: json['branch_id'] as int?,
        jobId: json['job_id'] as String?,
        isActive: json['is_active'] as int?,
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
        'created_at': createdAt,
      };
}
