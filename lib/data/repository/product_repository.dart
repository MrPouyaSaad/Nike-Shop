// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nike_shop/common/const.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/source/product_data_source.dart';

final productRepository = ProductRepository(
    dataSource: ProductDataSource(httpClient: Constants.httpClient));

abstract class IProductRepository {
  Future<List<ProductModel>> getProductList(int sort);
  Future<List<ProductModel>> searchProductList(String searchTerm);
}

class ProductRepository implements IProductRepository {
  IProductDataSource dataSource;
  ProductRepository({
    required this.dataSource,
  });
  @override
  Future<List<ProductModel>> getProductList(int sort) =>
      dataSource.getProductList(sort);

  @override
  Future<List<ProductModel>> searchProductList(String searchTerm) =>
      dataSource.searchProductList(searchTerm);
}
