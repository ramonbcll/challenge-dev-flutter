import 'package:application/src/core/dio_http_client.dart';
import 'package:application/src/core/http_client.dart';
import 'package:application/src/repositories/student_repository.dart';
import 'package:application/src/repositories/student_repository_imp.dart';
import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:application/src/provider/student_list_controller.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CustomInjector {
  CustomInjector._();

  static final CustomInjector _instance = CustomInjector._();

  final autoInjector = AutoInjector();

  static CustomInjector get instance => _instance;

  T get<T>() {
    return autoInjector.get<T>();
  }

  void init() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        baseUrl: 'https://653c0826d5d6790f5ec7c664.mockapi.io/api/v1',
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );

    autoInjector.addSingleton<Dio>(() => dio);

    autoInjector.addSingleton<HttpClientCommon>(DioHttpClient.new);

    autoInjector.add<StudentRepository>(StudentRepositoryImp.new);

    autoInjector.add<StudentListController>(StudentListController.new);

    autoInjector.commit();
  }
}
