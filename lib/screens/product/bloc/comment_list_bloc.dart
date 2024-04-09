import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/common/exception.dart';
import 'package:nike_shop/data/model/comment.dart';
import 'package:nike_shop/data/repository/comment_repository.dart';
part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository commentRepository;
  final int id;
  CommentListBloc({required this.commentRepository, required this.id})
      : super(CommentListLoading()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted || event is CommentListRefreshed) {
        try {
          emit(CommentListLoading());
          final comments = await commentRepository.getComments(id);
          emit(CommentListSuccess(comments: comments));
        } catch (e) {
          emit(CommentListError(exception: AppException()));
        }
      }
    });
  }
}
