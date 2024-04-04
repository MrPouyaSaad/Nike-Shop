// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:nike_shop/common/validate_res.dart';

import 'package:nike_shop/data/model/comment.dart';

abstract class ICommentDataSource {
  Future<List<CommentModel>> getComments(int id);
}

class CommentDataSource implements ICommentDataSource {
  final Dio httpClient;

  CommentDataSource({
    required this.httpClient,
  });
  @override
  Future<List<CommentModel>> getComments(int id) async {
    final response = await httpClient.get('comment/list?product_id=$id');
    validateResponse(response);
    List<CommentModel> comments = [];
    (response.data as List).forEach((json) {
      comments.add(CommentModel.fromJson(json));
    });
    return comments;
  }
}
