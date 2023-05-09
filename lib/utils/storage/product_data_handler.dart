import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDataHandler {
  static void saveProductSkuId(String skuId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("skuId", skuId);
  }

  static void saveServiceProductId(String serviceId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("serviceId", serviceId);
  }

  static Future<String> getServiceProductId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("serviceId") ?? "";
  }

  static Future<String> getProductSkuId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("skuId") ?? "";
  }
}
