import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/core/services/network_service/error_model/error_model.dart';
import 'package:supplies/main.dart';

abstract class DioHelper {
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
    Map<String, String>? headers,
  });

  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> put({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> delete({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> download({required String url});
}

class DioImpl extends DioHelper {
  DioImpl();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 8),
    ),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 100,
    ));

  @override
  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(seconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      "x-version": '1.0',
      "Database-App": "suppliers",
      "locale": CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
      'Authorization': 'Bearer ${await CacheHelper.getData(CacheKeys.token)}',
    };

    dio.options.baseUrl = base ?? dio.options.baseUrl;

    return await request(
      call: () async => await dio.get(
        endPoint,
        queryParameters: query,
        data: data,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
    Map<String, String>? headers,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(seconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (isMultipart) 'Accept': '*/*',
      "Database-App": "suppliers",
      "locale": await CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
      'Authorization': 'Bearer ${await CacheHelper.getData(CacheKeys.token)}',
      ...headers ?? {},
    };

    return await request(
      call: () async => await dio.post(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future<dynamic> put({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(seconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      "x-version": '1.0',
      "Database-App": "suppliers",
      "locale": await CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
      'Authorization': 'Bearer ${await CacheHelper.getData(CacheKeys.token)}',
    };

    return await request(
      call: () async => await dio.put(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future<dynamic> delete({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(seconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      "x-version": '1.0',
      "Database-App": "suppliers",
      "locale": await CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
      'Authorization': 'Bearer ${await CacheHelper.getData(CacheKeys.token)}',
    };

    return await request(
      call: () async => await dio.delete(
        endPoint,
        data: data,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future download({required String url}) async {
    return await Dio().get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));
  }

  Future uploadFormData(FormData formData, String url) async {
    Dio newDioOpj = Dio()
      ..interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100,
      ));

    return await request(
        call: () async => await newDioOpj.post(url,
            options: Options(headers: {
              'Content-Type': 'multipart/form-data',
              'Accept': 'application/json',
              "Database-App": "suppliers",
              'Authorization': 'Bearer ' + await CacheHelper.getData("token"),
              "x-version": '1.0',
              "locale": CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
            }),
            data: formData));
  }

  multiPartTheFile(File? file) async {
    if (file != null) {
      return await MultipartFile.fromFile(file.path, filename: file.path.split('/').last);
    } else {
      return null;
    }
  }

  // Unified request handler for all HTTP calls
  Future request({
    required Future<Response> Function() call,
  }) async {
    try {
      final r = await call.call();
      return r;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.cancel:
          throw CustomException(message: "Request has been canceled.");
        case DioExceptionType.connectionTimeout:
          throw CustomException(message: "Sorry! Your connection has timed out.");
        case DioExceptionType.badResponse:
          if (e.response!.statusCode == 401) {
            // Handle token refresh or logout
            reset();
          }
          throw CustomException(
            message: e.response?.data['message'] ?? "Something went wrong",
            // message: errorModel.errors?.isEmpty ?? true ? errorModel.message : errorModel.errors?.first.value?.first ?? e.response!.data['message'] ?? "Something went wrong",
          );

        case DioExceptionType.unknown:
          if (e.response!.statusCode == 422) {
            throw CustomException(
              message: e.response!.data['message'] ?? "Something went wrong",
              // message: errorModel.errors?.isEmpty ?? true ? errorModel.message : errorModel.errors?.first.value?.first ?? e.response!.data['message'] ?? "Something went wrong",
            );
          }

        case DioExceptionType.connectionError:
          if (e.error is SocketException) {
            throw CustomException(message: "No internet connection.");
          } else {
            throw CustomException(message: "Connection error.");
          }

        default:
          throw CustomException(message: "An unknown error occurred.");
      }
    } catch (e) {
      throw CustomException(message: "An unknown error occurred.");
    }
  }
}

void reset() async {
  await CacheHelper.clear();
  navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
}
