class Branch {
  int? id;
  String? name;

  Branch({this.id, this.name});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
