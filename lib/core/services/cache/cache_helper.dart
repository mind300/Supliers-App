import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static UsersType userType = CacheHelper.getData(CacheKeys.userType) == 'owner'
      ? UsersType.owner
      : CacheHelper.getData(CacheKeys.userType) == 'manager'
          ? UsersType.manager
          : UsersType.cashier;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData(String key) {
    try {
      return sharedPreferences!.get(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> setData(String key, dynamic val) async {
    if (val == null) return Future.value(false);

    if (key == 'Services') return await setIdsList('service_id', val);
    if (key == 'Gallery')
      return await sharedPreferences!.setBool('Gallery', true);
    if (val is bool) return await sharedPreferences!.setBool(key, val);
    if (val is double) return await sharedPreferences!.setDouble(key, val);
    if (val is String) return await sharedPreferences!.setString(key, val);
    if (val is int) return await sharedPreferences!.setInt(key, val);

    return Future.value(false); // unsupported type
  }

  static Future<bool> setIdsList(String idKey, dynamic jsonList) async {
    String ids = '';
    for (Map<String, dynamic> e in jsonList) {
      ids += '${e[idKey]} ';
    }
    return await setData(idKey, ids);
  }

  static List<int> getIdList(String idKey) {
    if (sharedPreferences!.containsKey(idKey)) {
      var response = getData(idKey).toString().trim();
      return response == ""
          ? []
          : response.split(' ').map((e) => int.parse(e)).toList();
    }
    return [];
  }

  static Future<bool> removeData(String key) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> clear() async {
    return await sharedPreferences!.clear();
  }
}
