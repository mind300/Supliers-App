class Content {
  int? id;
  String? name;
  int? discount;

  Content({this.id, this.name, this.discount});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as String?,
        discount: json['discount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'discount': discount,
      };
}
