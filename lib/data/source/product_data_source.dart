// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:nike_shop/common/validate_res.dart';
import 'package:nike_shop/data/model/product.dart';

abstract class IProductDataSource {
  Future<List<ProductModel>> getProductList(int sort);
  Future<List<ProductModel>> searchProductList(String searchTerm);
}

class ProductDataSource implements IProductDataSource {
  final Dio httpClient;
  ProductDataSource({
    required this.httpClient,
  });
  @override
  Future<List<ProductModel>> getProductList(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');

    validateResponse(response);

    List<ProductModel> products = [];

    (response.data as List)
        .map((json) => products.add(ProductModel.fromJson(json)));

    return products;
  }

  @override
  Future<List<ProductModel>> searchProductList(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');

    validateResponse(response);

    List<ProductModel> products = [];

    (response.data as List).map((json) {
      products.add(ProductModel.fromJson(json));
    });

    return products;
  }
}
