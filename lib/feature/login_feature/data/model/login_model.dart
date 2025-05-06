class LoginModel {
  int? userId;
  String? name;
  bool? isNew;
  String? role;
  String? token;
  String? deviceToken;
  String? message;
  int? isActive;
  int? expireIn;

  LoginModel({
    this.userId,
    this.name,
    this.isNew,
    this.role,
    this.token,
    this.deviceToken,
    this.message,
    this.isActive,
    this.expireIn,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userId: json['id'] as int?,
        name: json['name'].toString(),
        isNew: json['is_new'] as bool?,
        role: json['role'] as String?,
        token: json['token'] as String?,
        deviceToken: json['device_token'] as String?,
        message: json['message'] as String?,
        isActive: json['is_active'] as int?,
        expireIn: json['expire_in'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'is_new': isNew,
        'role': role,
        'token': token,
        'device_token': deviceToken,
        'message': message,
        'is_active': isActive,
        'expire_in': expireIn,
      };
}
