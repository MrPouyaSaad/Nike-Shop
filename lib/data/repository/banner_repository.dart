// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nike_shop/common/url.dart';
import 'package:nike_shop/data/model/banner.dart';
import 'package:nike_shop/data/source/banner_data_source.dart';

final bannerRepository = BannerRepository(
    bannerDataSource: BannerDataSource(httpClient: httpClient));

abstract class IBannerRepository {
  Future<List<BannerModel>> getBanners();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource bannerDataSource;
  BannerRepository({
    required this.bannerDataSource,
  });
  @override
  Future<List<BannerModel>> getBanners() => bannerDataSource.getBanners();
}
