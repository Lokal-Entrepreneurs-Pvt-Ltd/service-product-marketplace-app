import 'package:lokal/utils/storage/preference_constants.dart';
import 'package:lokal/utils/storage/preference_util.dart';

abstract class UserDataHandler {
  static void saveUserToken(String userToken) async {
    PreferenceUtils.setString(AUTH_TOKEN, userToken);
  }

  static void clearUserToken() {
    PreferenceUtils.clearStorage();
  }

  static String getUserToken() {
    return PreferenceUtils.getString(AUTH_TOKEN);
  }

  static void saveEmailPassword(String email, String passwordpassword) async {
    PreferenceUtils.setString(EMAIL, email);
    // PreferenceUtils.setString(PASSWORD, password);
  }

  static String getUserName()  {
    return PreferenceUtils.getString(FIRST_NAME, "");
  }

  static void saveUserName(String name) {
    PreferenceUtils.setString(FIRST_NAME, name);
  }

  static String getUserEmail()  {
    return PreferenceUtils.getString(EMAIL, "");
  }

  static void saveUserEmail(String email) {
    PreferenceUtils.setString(EMAIL, email);
  }

  static String getUserId()  {
    return PreferenceUtils.getString(USER_ID, "");
  }

  static void saveUserId(int userId) {
    PreferenceUtils.setInt(USER_ID, userId);
  }

  static String getUserGST()  {
    return PreferenceUtils.getString(GST_TAX_VAT, "");
  }

  static void saveUserGST(String gst) {
    PreferenceUtils.setString(GST_TAX_VAT, gst);
  }

  static String getUserDob()  {
    return PreferenceUtils.getString(DOB, "");
  }

  static void saveUserDob(String dob) {
    PreferenceUtils.setString(DOB, dob);
  }

  static String getUserPhone()  {
    return PreferenceUtils.getString(PHONE_NUMBER, "");
  }

  static void saveUserPhone(String phone) {
    PreferenceUtils.setString(PHONE_NUMBER, phone);
  }

  static bool getIsUserVerified() {
    return PreferenceUtils.getBool(IS_USER_VERIFIED, false);
  }

  static void saveIsUserVerified(bool isUserVerified) {
    PreferenceUtils.setBool(IS_USER_VERIFIED, isUserVerified);
  }
}
