import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Constants {
  static const String clientSecret = 'kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC';
  static const scrollPhysics = BouncingScrollPhysics();
  static const String baseUrl = 'http://expertdevelopers.ir/api/v1/';
  static final httpClient = Dio(BaseOptions(baseUrl: baseUrl));
}
