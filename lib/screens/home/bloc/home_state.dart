part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final AppException exception;

  const HomeError({
    required this.exception,
  });

  @override
  List<Object> get props => [exception];
}

final class HomeSuccess extends HomeState {
  final List<BannerModel> banners;
  final List<ProductModel> popularProducts;
  final List<ProductModel> latestProducts;

  const HomeSuccess({
    required this.banners,
    required this.popularProducts,
    required this.latestProducts,
  });

  @override
  List<Object> get props => [banners, latestProducts, popularProducts];
}
