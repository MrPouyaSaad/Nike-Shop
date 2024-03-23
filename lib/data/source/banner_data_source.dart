// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:nike_shop/common/validate_res.dart';

import 'package:nike_shop/data/model/banner.dart';

abstract class IBannerDataSource {
  Future<List<Bannermodel>> getBanners();
}

class BannerDataSource implements IBannerDataSource {
  final Dio httpClient;
  BannerDataSource({
    required this.httpClient,
  });

  @override
  Future<List<Bannermodel>> getBanners() async {
    final response = await httpClient.get('banner/slider');

    validateResponse(response);

    final List<Bannermodel> banners = [];
    (response.data as List).map((json) => banners.add(json));
    return banners;
  }
}
