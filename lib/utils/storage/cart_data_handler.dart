import 'package:lokal/utils/storage/preference_util.dart';

import 'cart_handler_constants.dart';

class CartDataHandler {
  static void saveCartId(String cartId) {
    PreferenceUtils.setString(CART_ID, cartId);
  }

  static String getCartId() {
    return PreferenceUtils.getString(CART_ID);
  }

  static List<String> getCartItems() {
    return PreferenceUtils.getStringList(CART_ITEMS,[]);
  }

  static void saveCartItems(List<String> items) {
    PreferenceUtils.setStringList(CART_ITEMS, items);
  }
}
