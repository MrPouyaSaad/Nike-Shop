// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nike_shop/common/const.dart';
import 'package:nike_shop/data/model/comment.dart';
import 'package:nike_shop/data/source/comment_data_source.dart';

final commentRepository = CommentRepository(
    dataSource: CommentDataSource(httpClient: Constants.httpClient));

abstract class ICommentRepository {
  Future<List<CommentModel>> getComments(int id);
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;
  CommentRepository({
    required this.dataSource,
  });
  @override
  Future<List<CommentModel>> getComments(int id) => dataSource.getComments(id);
}
