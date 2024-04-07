// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nike_shop/common/const.dart';
import 'package:nike_shop/common/exception.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/repository/banner_repository.dart';
import 'package:nike_shop/data/repository/product_repository.dart';
import 'package:nike_shop/screens/common/slider.dart';
import 'package:nike_shop/screens/home/bloc/home_bloc.dart';
import 'package:nike_shop/screens/product/product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
          bannerRepository: bannerRepository,
          productRepository: productRepository,
        );
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: ((context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                    itemCount: 5,
                    padding: const EdgeInsets.only(bottom: 64),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Image.asset(
                            'assets/images/nike_logo.png',
                            height: 28,
                          ).marginSymmetric(vertical: 16);
                        case 2:
                          return BannerSlider(banners: state.banners)
                              .marginOnly(bottom: 32);
                        case 3:
                          return _HorizontalProductList(
                            title: 'جدیدترین',
                            onTap: () {},
                            products: state.latestProducts,
                          );
                        case 4:
                          return _HorizontalProductList(
                            title: 'پربازدیدترین',
                            onTap: () {},
                            products: state.popularProducts,
                          );
                        default:
                          return Container();
                      }
                    });
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return AppExceptionWidget(
                  exceptionMessage: state.exception.message,
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                );
              } else {
                throw Exception('state is not supported');
              }
            }),
          ),
        ),
      ),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductModel> products;
  const _HorizontalProductList({
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              TextButton(onPressed: onTap, child: const Text('مشاهده همه'))
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: Constants.scrollPhysics,
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemBuilder: ((context, index) {
              final product = products[index];
              return ProductItem(product: product);
            }),
          ),
        )
      ],
    );
  }
}
