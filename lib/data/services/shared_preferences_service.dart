import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _tokenKey = 'TOKEN';

  Future<String?> fetchToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString(_tokenKey);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveToken(String? token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (token == null) {
        await sharedPreferences.remove(_tokenKey);
      } else {
        await sharedPreferences.setString(_tokenKey, token);
      }
    } catch (e) {
      // Handle error if necessary
    }
  }
}
