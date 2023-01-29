import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDataHandler {
  static void saveProductSkuId(String skuId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("skuId", skuId);
  }

  static Future<String> getProductSkuId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("skuId") ?? "";
  }
}
