class Content {
  int? id;
  String? name;
  int? discount;
  int? offerId;

  Content({this.id, this.name, this.discount, this.offerId});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as String?,
        discount: json['discount'] as int?,
        offerId: json['offer_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'discount': discount,
        'offer_id': offerId,
      };
}
