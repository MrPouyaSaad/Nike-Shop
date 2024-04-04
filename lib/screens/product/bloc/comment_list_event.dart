part of 'comment_list_bloc.dart';

sealed class CommentListEvent extends Equatable {
  const CommentListEvent();

  @override
  List<Object> get props => [];
}

final class CommentListStarted extends CommentListEvent {}

final class CommentListRefreshed extends CommentListEvent {}
