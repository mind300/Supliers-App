class Manager {
  int? id;
  String? name;
  String? email;
  int? jobId;

  Manager({this.id, this.name, this.email, this.jobId});

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        jobId: json['job_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'job_id': jobId,
      };
}
