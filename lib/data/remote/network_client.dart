import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkClient {
  final dio = Dio();

  NetworkClient() {
    dio.interceptors.add(LogInterceptor(
        logPrint: (log) => debugPrint(log.toString()),
        requestBody: true,
        responseBody: true));
  }
}
