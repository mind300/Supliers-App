class EndPoints {
  static const String baseUrl = 'https://suppliers-api.all-classes.com/api/suppliers';
  static const String login = '$baseUrl/auth/login';
  static const String changePassword = '$baseUrl/auth/password/change';
  static const String branch = '$baseUrl/branches';
  static const String me = '$baseUrl/profiles/me';
  static const String cashiers = '$baseUrl/cashiers';
  static const String addBranch = '$baseUrl/owners/branches';
  static const String manager = '$baseUrl/managers';
  static const String offer = '$baseUrl/offers';
  static const String allManagers = '$baseUrl/managers/list';
  static const String categoriesList = '$baseUrl/categories/list';
  static const String allBranches = '$baseUrl/branches/list';
  static const String about = '$baseUrl/pages/1';
  static const String updateProfile = '$baseUrl/profiles/update';
  static const String allBranchesWithoutManagers = '$baseUrl/branches/withoutManagers';
  static const String transactions = '$baseUrl/transactions';


}
