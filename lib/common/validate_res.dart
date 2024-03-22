import 'package:dio/dio.dart';
import 'package:nike_shop/common/exeption.dart';

validateResponse(Response response) {
  if (response.statusCode != 200) {
    throw Exeption();
  }
}
