import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinity_box_task/utils/base_repository.dart';

class ProductDetailsRepository with BaseRepository {
  //saving the given product in firestore 'cart' collection
  Future<void> addToCart(String email, int productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? userProductCart = prefs.getStringList(email);
      if (userProductCart != null) {
        if (!userProductCart.contains(productId.toString())) {
          userProductCart.add(productId.toString());
          await prefs.setStringList(email, userProductCart);
        }
      } else {
        List<String> cart = [];
        cart.add(productId.toString());
        await prefs.setStringList(email, cart);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
