import 'package:nike_shop/data/model/product.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProductList(int sort);
  Future<List<ProductModel>> searchProductList(int sort);
}
