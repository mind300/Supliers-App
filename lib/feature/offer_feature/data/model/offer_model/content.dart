class Content {
  int? id;
  int? categoryId;
  String? categoryName;
  int? brandId;
  String? brandInfo;
  String? title;
  int? discount;
  String? qrCode;
  String? description;
  List<String>? images;
  String? createdAt;

  Content({
    this.id,
    this.categoryId,
    this.categoryName,
    this.brandId,
    this.brandInfo,
    this.title,
    this.discount,
    this.qrCode,
    this.description,
    this.images,
    this.createdAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        categoryId: json['category_id'] as int?,
        categoryName: json['category_name'] as String?,
        brandId: json['brand_id'] as int?,
        brandInfo: json['brand_info'] as String?,
        title: json['title'] as String?,
        discount: json['discount'] as int?,
        qrCode: json['qr_code'] as String?,
        description: json['description'] as String?,
        images: json['images'].map((e) => e.toString()).toList().cast<String>(),
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'category_name': categoryName,
        'brand_id': brandId,
        'brand_info': brandInfo,
        'title': title,
        'discount': discount,
        'qr_code': qrCode,
        'description': description,
        'images': images,
        'created_at': createdAt,
      };
}
