import 'cashier.dart';
import 'manager.dart';
import 'owner.dart';

class Content {
  int? id;
  String? name;
  String? city;
  String? street;
  String? buildingNumber;
  String? floorNumber;
  Manager? manager;
  List<Cashier>? cashiers;
  Owner? owner;
  String? createdAt;

  Content({
    this.id,
    this.name,
    this.city,
    this.street,
    this.buildingNumber,
    this.floorNumber,
    this.manager,
    this.cashiers,
    this.owner,
    this.createdAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as String?,
        city: json['city'] as String?,
        street: json['street'] as String?,
        buildingNumber: json['building_number'] as String?,
        floorNumber: json['floor_number'] as String?,
        manager: json['manager'] == null
            ? null
            : Manager.fromJson(json['manager'] as Map<String, dynamic>),
        cashiers: (json['cashiers'] as List<dynamic>?)
            ?.map((e) => Cashier.fromJson(e as Map<String, dynamic>))
            .toList(),
        owner: json['owner'] == null
            ? null
            : Owner.fromJson(json['owner'] as Map<String, dynamic>),
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'street': street,
        'building_number': buildingNumber,
        'floor_number': floorNumber,
        'manager': manager?.toJson(),
        'cashiers': cashiers?.map((e) => e.toJson()).toList(),
        'owner': owner?.toJson(),
        'created_at': createdAt,
      };
}
