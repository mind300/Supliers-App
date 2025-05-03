class Owner {
  int? id;
  String? name;
  String? email;
  int? isActive;
  String? createdAt;

  Owner({this.id, this.name, this.email, this.isActive, this.createdAt});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        isActive: json['is_active'] as int?,
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'is_active': isActive,
        'created_at': createdAt,
      };
}
