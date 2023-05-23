import 'package:emergen/models/product_response.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  RxList<Product> _products = <Product>[].obs;

  set products(List<Product> value) {
    _products.assignAll(value);
  }

  List<Product> get products => _products;
}
