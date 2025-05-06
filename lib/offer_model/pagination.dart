class Pagination {
  int? totalItems;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  String? firstPageUrl;
  dynamic nextPageUrl;
  dynamic perviousPageUrl;

  Pagination({
    this.totalItems,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
    this.firstPageUrl,
    this.nextPageUrl,
    this.perviousPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalItems: json['total_items'] as int?,
        perPage: json['per_page'] as int?,
        currentPage: json['current_page'] as int?,
        lastPage: json['last_page'] as int?,
        from: json['from'] as int?,
        to: json['to'] as int?,
        firstPageUrl: json['first_page_url'] as String?,
        nextPageUrl: json['next_page_url'] as dynamic,
        perviousPageUrl: json['pervious_page_url'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'total_items': totalItems,
        'per_page': perPage,
        'current_page': currentPage,
        'last_page': lastPage,
        'from': from,
        'to': to,
        'first_page_url': firstPageUrl,
        'next_page_url': nextPageUrl,
        'pervious_page_url': perviousPageUrl,
      };
}
