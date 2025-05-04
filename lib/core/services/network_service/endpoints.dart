class EndPoints {
  static const String baseUrl = 'https://dev.all-classes.com/api/suppliers';
  static const String login = '$baseUrl/auth/login';
  static const String branch = '$baseUrl/branches';
  static const String me = '$baseUrl/profiles/me';
  static const String cashiers = '$baseUrl/cashiers';
  static const String addBranch = '$baseUrl/owners/branches';
  static const String manager = '$baseUrl/managers';
  static const String allManagers = '$baseUrl/managers/list';
  static const String allBranches = '$baseUrl/branches/list';
  static const String allBranchesWithoutManagers = '$baseUrl/branches/withoutManagers';
}
