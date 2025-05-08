class TransactionsResponse {
  final List<Transaction> content;
  final String total;
  final bool success;
  final String message;
  final int status;
  final Pagination pagination;

  TransactionsResponse({
    required this.content,
    required this.total,
    required this.success,
    required this.message,
    required this.status,
    required this.pagination,
  });

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) {
    return TransactionsResponse(
      content: (json['content'] as List)
          .map((item) => Transaction.fromJson(item))
          .toList(),
      total: json['total'] ?? '00.0',
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}

class Transaction {
  final int id;
  final String totalBeforeDiscount;
  final String userAmount;
  final String userDiscount;
  final String status;
  final String createdAt;
  final int? supplierId;
  final int? branchId;
  final int? brandId;
  final Cashier? cashier;
  final Branch? branch;
  final Brand? brand;

  Transaction({
    required this.id,
    required this.totalBeforeDiscount,
    required this.userAmount,
    required this.userDiscount,
    required this.status,
    required this.createdAt,
    this.supplierId,
    this.branchId,
    this.brandId,
    this.cashier,
    this.branch,
    this.brand,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      totalBeforeDiscount: json['total_before_discount'] ?? '0',
      userAmount: json['user_amount'] ?? '0',
      userDiscount: json['user_discount'] ?? '0',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      supplierId: json['supplier_id'],
      branchId: json['branch_id'],
      brandId: json['brand_id'],
      cashier: json['cashier'] != null ? Cashier.fromJson(json['cashier']) : Cashier(id: 0, name: ''),
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : Branch(id: 0, name: ''),
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : Brand(id: 0, name: ''),

    );
  }
}

class Cashier {
  final int id;
  final String name;

  Cashier({
    required this.id,
    required this.name,
  });

  factory Cashier.fromJson(Map<String, dynamic> json) {
    return Cashier(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}

class Branch {
  final int id;
  final String name;

  Branch({
    required this.id,
    required this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}

class Brand {
  final int id;
  final String name;

  Brand({
    required this.id,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}

class Pagination {
  final int totalItems;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int from;
  final int to;
  final String firstPageUrl;
  final String? nextPageUrl;
  final String? previousPageUrl;

  Pagination({
    required this.totalItems,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.from,
    required this.to,
    required this.firstPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalItems: json['total_items'] ?? 0,
      perPage: json['per_page'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      from: json['from'] ?? 0,
      to: json['to'] ?? 0,
      firstPageUrl: json['first_page_url'] ?? '',
      nextPageUrl: json['next_page_url'],
      previousPageUrl: json['pervious_page_url'],
    );
  }
}
