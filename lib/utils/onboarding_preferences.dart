import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPreferences {
  static SharedPreferences? _preferences;

  static const _keyCheckedItem = 'checkeditem';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setOnboardingCheck(String checkedItem) async =>
      await _preferences!.setString(_keyCheckedItem, checkedItem);

  static String? getOnboardingCheck() =>
      _preferences!.getString(_keyCheckedItem);
}
