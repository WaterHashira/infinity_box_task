import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/utils/base_repository.dart';

class ProductListRepository with BaseRepository {
  //getting the list of all the product categories available
  Future<List<String>> getProductCategories() async {
    try {
      final res = await dio.get('/products/categories');
      print('---------------------------------------------->' + res.data);
      List<String> categories = [];
      for (var category in res.data) {
        categories.add(categories.toString());
      }
      return categories;
    } catch (e) {
      print(
          '------------------------------------------------->' + e.toString());
      throw Exception(e);
    }
  }

  //getting the list of all available products
  Future<List<Product>> getAllProducts() async {
    try {
      print(
          '------------------------------------------------------------------------------------------------------------------------------------------->sssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
      final res = await dio.get('/products');
      List<Product> allProducts = [];
      for (var pro in res.data) {
        allProducts.add(Product.fromJson(pro));
      }
      print(
          'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEENNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNDDDDDDDDDDDDDDDDDDDDDDD');
      print(res.data);
      return allProducts;
    } catch (e) {
      print(
          'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR----------------> $e');
      throw Exception(e);
    }
  }

  //getting the list of all available products in searched category
  Future<List<Product>> getFilterProducts(String category) async {
    try {
      final res = await dio.get('/products/category/$category');
      List<Product> filterProducts = [];
      for (var pro in res.data) {
        filterProducts.add(Product.fromJson(pro));
      }
      return filterProducts;
    } catch (e) {
      throw Exception(e);
    }
  }

  //getting the list of all available products searched
  Future<List<Product>> getSearchProducts(String productName) async {
    List<Product> searchProducts = [];
    return Future.delayed(const Duration(seconds: 3))
        .then((value) => searchProducts);
  }
}
