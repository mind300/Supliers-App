class ContantBranchCashier {
  final int? id;
  final String? name;
  final String? address;
  final String? city;
  final String? street;
  final String? buildingNumber;
  final String? floorNumber;
  final int? brandId;
  final int? managerId;
  final int? ownerId;
  final String? createdAt;
  final String? updatedAt;
  final int? laravelThroughKey;

  ContantBranchCashier({
    this.id,
    this.name,
    this.address,
    this.city,
    this.street,
    this.buildingNumber,
    this.floorNumber,
    this.brandId,
    this.managerId,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.laravelThroughKey,
  });

  factory ContantBranchCashier.fromJson(Map<String, dynamic> json) {
    return ContantBranchCashier(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      street: json['street'],
      buildingNumber: json['building_number'],
      floorNumber: json['floor_number'],
      brandId: json['brand_id'],
      managerId: json['manager_id'],
      ownerId: json['owner_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      laravelThroughKey: json['laravel_through_key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'street': street,
      'building_number': buildingNumber,
      'floor_number': floorNumber,
      'brand_id': brandId,
      'manager_id': managerId,
      'owner_id': ownerId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'laravel_through_key': laravelThroughKey,
    };
  }
}
