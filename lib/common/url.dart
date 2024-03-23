import 'package:dio/dio.dart';

const baseUrl = 'http://expertdevelopers.ir/api/v1/';
final httpClient = Dio(BaseOptions(baseUrl: baseUrl));
