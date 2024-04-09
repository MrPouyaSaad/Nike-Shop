// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nike_shop/common/const.dart';
import 'package:nike_shop/data/model/auth.dart';
import 'package:nike_shop/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository =
    AuthRepository(dataSorce: AuthDataSource(httpClient: Constants.httpClient));

abstract class IAuthRepository {
  Future<void> login({required String username, required String password});
  Future<void> register({required String username, required String password});
  Future<void> refreshToken(String token);
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthModel?> authNotifier = ValueNotifier(null);
  final IAuthDataSorce dataSorce;
  AuthRepository({
    required this.dataSorce,
  });
  @override
  Future<void> login(
      {required String username, required String password}) async {
    final AuthModel authModel =
        await dataSorce.login(username: username, password: password);
    _saveToken(authModel);
  }

  @override
  Future<void> register(
      {required String username, required String password}) async {
    final AuthModel authModel =
        await dataSorce.register(password: password, username: username);
    _saveToken(authModel);
  }

  @override
  Future<void> refreshToken(String token) async {
    final AuthModel authModel = await dataSorce.refreshToken(token);
    _saveToken(authModel);
  }

  Future<void> _saveToken(AuthModel authModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString("access_token", authModel.accessToken);
    sharedPreferences.setString("refresh_token", authModel.refreshToken);
  }

  Future<void> getAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString('access_token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authNotifier.value =
          AuthModel(accessToken: accessToken, refreshToken: refreshToken);
    }
  }
}
