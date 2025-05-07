class Cashier {
  int? id;
  String? name;
  String? email;
  int? code;
  int? branchId;
  int? jobId;
  int? isActive;
  String? image;

  Cashier({
    this.id,
    this.name,
    this.email,
    this.code,
    this.branchId,
    this.jobId,
    this.isActive,
    this.image,
  });

  factory Cashier.fromJson(Map<String, dynamic> json) => Cashier(
        id: json['id'] as int?,
        name: json['name'] as String?,
        jobId: json['job_id'] as int?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'code': code,
        'branch_id': branchId,
        'job_id': jobId,
        'is_active': isActive,
      };
}
