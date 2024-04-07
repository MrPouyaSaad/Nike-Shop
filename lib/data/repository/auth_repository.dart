// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nike_shop/common/const.dart';
import 'package:nike_shop/data/source/auth_data_source.dart';

final authRepository =
    AuthRepository(dataSorce: AuthDataSource(httpClient: Constants.httpClient));

abstract class IAuthRepository {
  Future<void> login({required String username, required String password});
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSorce dataSorce;
  AuthRepository({
    required this.dataSorce,
  });
  @override
  Future<void> login({required String username, required String password}) =>
      dataSorce.login(username: username, password: password);
}
