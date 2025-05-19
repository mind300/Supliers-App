class Branch {
  int? id;
  String? name;
  int? ownerId;

  Branch({this.id, this.name, this.ownerId});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'] as int?,
        name: json['name'] as String?,
        ownerId: json['owner_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'owner_id': ownerId,
      };
}
