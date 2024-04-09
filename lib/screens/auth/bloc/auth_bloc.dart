// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/common/exception.dart';

import 'package:nike_shop/data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLogin;
  final IAuthRepository authRepository;
  AuthBloc({
    this.isLogin = true,
    required this.authRepository,
  }) : super(AuthInitial(isLogin)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthStarted) {
          emit(AuthInitial(isLogin));
        } else if (event is AuthButtonClicked) {
          if (isLogin) {
            emit(AuthLoading(isLogin));
            await authRepository.login(
                username: event.username, password: event.password);
            emit(AuthSuccess(isLogin));
          } else {
            emit(AuthLoading(isLogin));

            await authRepository.register(
                username: event.username, password: event.password);
            emit(AuthSuccess(isLogin));
          }
        } else if (event is AuthModeChangeButtonClicked) {
          isLogin = !isLogin;
          print(isLogin);
          emit(AuthInitial(isLogin));
        }
      } catch (e) {
        emit(AuthError(isLogin, AppException()));
      }
    });
  }
}
