// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/common/exception.dart';
import 'package:nike_shop/common/sort.dart';
import 'package:nike_shop/data/model/banner.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/repository/banner_repository.dart';
import 'package:nike_shop/data/repository/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({
    required this.bannerRepository,
    required this.productRepository,
  }) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        try {
          emit(HomeLoading());
          final banners = await bannerRepository.getBanners();
          final latestProducts =
              await productRepository.getProductList(ProductSort.latest);
          final popularProducts =
              await productRepository.getProductList(ProductSort.popular);

          emit(HomeSuccess(
              banners: banners,
              popularProducts: popularProducts,
              latestProducts: latestProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
