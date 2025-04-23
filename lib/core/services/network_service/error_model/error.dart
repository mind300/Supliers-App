class Error {
  String? key;
  List<dynamic>? value;

  Error({this.key, this.value});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json['key'] as String?,
        value: json['value'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };
}
