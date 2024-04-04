import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/common/exception.dart';
import 'package:nike_shop/common/scroll_physics.dart';
import 'package:nike_shop/common/theme.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/repository/comment_repository.dart';
import 'package:nike_shop/screens/common/image_service.dart';
import 'package:nike_shop/screens/common/price.dart';
import 'package:nike_shop/screens/product/bloc/comment_list_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: LightThemeColors.primaryTextColor,
            label: const Text('افزودن به سبد خرید'),
          ),
        ),
        body: CustomScrollView(
          physics: scrollPhysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(imageUrl: product.imageUrl),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.previousPrice.withPriceLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough),
                            ),
                            Text(product.price.withPriceLabel),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                        'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود'),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نظرات کاربران',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                            onPressed: () {}, child: const Text('ثبت نظر')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _CommentList(product: product),
          ],
        ),
      ),
    );
  }
}

class _CommentList extends StatelessWidget {
  const _CommentList({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (context) {
        final commentListBloc = CommentListBloc(
            commentRepository: commentRepository, id: product.id);

        commentListBloc.add(CommentListStarted());
        return commentListBloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
          builder: (context, state) {
        if (state is CommentListLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CommentListSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final comment = state.comments[index];

              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: themeData.dividerColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.title),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              comment.email,
                              style: themeData.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(comment.date,
                            style: themeData.textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      comment.content,
                      style: const TextStyle(height: 1.4),
                    ),
                  ],
                ),
              );
            }),
          );
        } else if (state is CommentListError) {
          return SliverToBoxAdapter(
            child: AppExceptionWidget(
              exceptionMessage: state.exception.message,
              onTap: () {
                BlocProvider.of<CommentListBloc>(context)
                    .add(CommentListRefreshed());
              },
            ),
          );
        } else {
          throw Exception('state is not supported');
        }
      }),
    );
  }
}
