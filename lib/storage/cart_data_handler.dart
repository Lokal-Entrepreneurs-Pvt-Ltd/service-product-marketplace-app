import 'package:shared_preferences/shared_preferences.dart';

abstract class CartDataHandler {
  static void saveCartData(String cartId, List<String> cartItems) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("cartId", cartId);
    await prefs.setStringList("cartItems", cartItems);
  }

  static Future<String> getCartId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("cartId") ?? "";
  }

  static Future<List<String>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList("cartItems") ?? [];
  }
}
