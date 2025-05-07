class Content {
  String? name;
  int? id;

  Content({this.name, this.id});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        name: json['name'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
