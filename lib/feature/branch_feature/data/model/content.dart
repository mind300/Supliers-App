class Content {
  int? id;
  dynamic name;
  String? city;
  String? street;
  String? buildingNumber;
  String? floorNumber;
  dynamic manager;
  dynamic owner;
  dynamic managerId;
  dynamic ownerId;
  String? createdAt;

  Content({
    this.id,
    this.name,
    this.city,
    this.street,
    this.buildingNumber,
    this.floorNumber,
    this.manager,
    this.owner,
    this.managerId,
    this.ownerId,
    this.createdAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as dynamic,
        city: json['city'] as String?,
        street: json['street'] as String?,
        buildingNumber: json['building_number'] as String?,
        floorNumber: json['floor_number'] as String?,
        manager: json['manager'] as dynamic,
        owner: json['owner'] as dynamic,
        managerId: json['manager_id'] as dynamic,
        ownerId: json['owner_id'] as dynamic,
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'street': street,
        'building_number': buildingNumber,
        'floor_number': floorNumber,
        'manager': manager,
        'owner': owner,
        'manager_id': managerId,
        'owner_id': ownerId,
        'created_at': createdAt,
      };
}
