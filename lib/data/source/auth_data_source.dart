// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:nike_shop/common/const.dart';
import 'package:nike_shop/common/validate_res.dart';

import 'package:nike_shop/data/model/auth.dart';

abstract class IAuthDataSorce {
  Future<AuthModel> register(
      {required String username, required String password});
  Future<AuthModel> login({required String username, required String password});
  Future<AuthModel> refreshToken(String token);
}

class AuthDataSource implements IAuthDataSorce {
  final Dio httpClient;
  AuthDataSource({
    required this.httpClient,
  });
  @override
  Future<AuthModel> login(
      {required String username, required String password}) async {
    final response = await httpClient.post('auth/token', data: {
      'grant_type': 'password',
      'client_id': 2,
      'client_secret': Constants.clientSecret,
      'username': username,
      'password': password
    });
    validateResponse(response);
    return AuthModel(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token']);
  }

  @override
  Future<AuthModel> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> register(
      {required String username, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
