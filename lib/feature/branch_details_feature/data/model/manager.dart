class Manager {
  int? id;
  String? name;
  String? email;
  String? image;
  int? jobId;

  Manager({this.id, this.name, this.email, this.jobId, this.image});

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        email: json['email'] as String?,
        jobId: json['job_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'image': image,
        'job_id': jobId,
      };
}
