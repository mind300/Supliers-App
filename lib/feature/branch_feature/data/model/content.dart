class Content {
  int? id;
  String? name;
  String? managerName;

  Content({
    this.id,
    this.name,
    this.managerName,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as dynamic,
        managerName: json['manager_name'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'manager_name': managerName,
      };
}
