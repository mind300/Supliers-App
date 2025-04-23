// // ignore_for_file: implementation_imports

// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:dio/dio.dart' as di;

// import 'package:dio/src/multipart_file.dart' as multipart_file;
// import 'package:get/get.dart';
// import 'package:karwah/core/functions/reset_credintails.dart';
// import 'package:karwah/core/localization/app_strings.dart';
// import 'package:karwah/core/routes/app_routes.dart';
// import 'package:karwah/core/services/cache/cache_helper.dart';
// import 'package:karwah/core/services/cache/cache_keys.dart';
// import 'package:karwah/core/services/network_service/endpoints.dart';
// import 'package:karwah/core/services/network_service/error.dart';
// import 'package:karwah/core/services/network_service/error_model/error_model.dart';
// import 'package:karwah/core/themes/toast_manager.dart';

// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// //import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// abstract class DioHelper {
//   Future<dynamic> post({
//     String? base,
//     required String endPoint,
//     dynamic data,
//     dynamic query,
//     String? token,
//     ProgressCallback? progressCallback,
//     CancelToken? cancelToken,
//     int? timeOut,
//     bool isMultipart = false,
//   });

//   Future<dynamic> get({
//     String? base,
//     required String endPoint,
//     dynamic data,
//     dynamic query,
//     String? token,
//     CancelToken? cancelToken,
//     int? timeOut,
//     bool isMultipart = false,
//   });

//   Future<dynamic> download({required String url});
// }

// class DioImpl extends DioHelper {
//   DioImpl();

//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: EndPoints.baseUrl,
//       receiveDataWhenStatusError: true,
//       connectTimeout: const Duration(seconds: 8),
//     ),
//   )..interceptors.add(PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: false,
//       error: true,
//       compact: true,
//       maxWidth: 100));

//   @override
//   Future<dynamic> get({
//     String? base,
//     required String endPoint,
//     dynamic data,
//     dynamic query,
//     String? token,
//     CancelToken? cancelToken,
//     int? timeOut,
//     bool isMultipart = false,
//   }) async {
//     if (timeOut != null) {
//       dio.options.connectTimeout = Duration(seconds: timeOut);
//     }

//     dio.options.headers = {
//       if (isMultipart) 'Content-Type': 'multipart/form-data',
//       if (!isMultipart) 'Content-Type': 'application/json',
//       if (!isMultipart) 'Accept': 'application/json',
//       "x-version": '1.0',
//       "locale": CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
//       'Authorization': 'Bearer ${await CacheHelper.getData(CacheKeys.token)}',
//     };
// //just for test
//     dio.options.baseUrl = base ?? dio.options.baseUrl;

//     dio.options.baseUrl = base ?? dio.options.baseUrl;
//     return await request(
//       call: () async => await dio.get(
//         endPoint,
//         queryParameters: query,
//         data: data,
//         cancelToken: cancelToken,
//       ),
//     );
//   }

//   @override
//   Future<dynamic> post({
//     String? base,
//     required String endPoint,
//     dynamic data,
//     dynamic query,
//     String? token,
//     ProgressCallback? progressCallback,
//     CancelToken? cancelToken,
//     int? timeOut,
//     bool isMultipart = false,
//   }) async {
//     if (timeOut != null) {
//       dio.options.connectTimeout = Duration(seconds: timeOut);
//     }

//     dio.options.headers = {
//       if (isMultipart) 'Content-Type': 'multipart/form-data',
//       if (!isMultipart) 'Content-Type': 'application/json',
//       if (!isMultipart) 'Accept': 'application/json',
//       if (isMultipart) 'Accept': '*/*',
//       "locale": await CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
//       'Authorization': 'Bearer ${await CacheHelper.getData(CacheKeys.token)}',
//     };

//     return await request(
//       call: () async => await dio.post(
//         endPoint,
//         data: data,
//         queryParameters: query,
//         onSendProgress: progressCallback,
//         cancelToken: cancelToken,
//       ),
//     );
//   }

//   @override
//   Future download({required String url}) async {
//     return await Dio().get(url,
//         options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           validateStatus: (status) {
//             return status! < 500;
//           },
//         ));
//   }

//   Future uploadFormData(di.FormData formData, String url) async {
//     Dio newDioOpj = Dio()
//       ..interceptors.add(PrettyDioLogger(
//           requestBody: true,
//           requestHeader: true,
//           responseBody: true,
//           responseHeader: false,
//           error: true,
//           compact: true,
//           maxWidth: 100));

//     return await request(
//         call: () async => await newDioOpj.post(url,
//             options: Options(headers: {
//               'Content-Type': 'multipart/form-data',
//               'Accept': 'application/json',
//               'Authorization': 'bearer ' + await CacheHelper.getData("token"),
//               "x-version": '1.0',
//               "locale": CacheHelper.getData(CacheKeys.languageCode) ?? 'ar',
//             }),
//             data: formData));
//   }

//   multiPartTheFile(File? file) async {
//     if (file != null) {
//       multipart_file.MultipartFile fileChunks =
//           await multipart_file.MultipartFile.fromFile(file.path,
//               filename: file.path.split('/').last);
//       return fileChunks;
//     } else {
//       return null;
//     }
//   }
// }

// extension on DioHelper {
//   Future request({
//     required Future<di.Response> Function() call,
//   }) async {
//     try {
//       final r = await call.call();
//       return r;
//     } on DioException catch (e) {
//       switch (e.type) {
//         case DioExceptionType.cancel:
//           throw CustomException("request has been canceled");
//         case DioExceptionType.connectionTimeout:
//           throw CustomException("sorry! your connection has timed out!");

//         case DioExceptionType.badResponse:
//           if (e.response!.statusCode == 401) {
//             resetCredintails();
//           }
//           ErrorModel errorModel = ErrorModel.fromJson(e.response!.data);
//           throw CustomException(
//             errorModel.errors!.isEmpty
//                 ? errorModel.message
//                 : errorModel.errors?.first.value?.first ??
//                     e.response!.data['message'] ??
//                     AppStrings.somethingWentWrong.tr,
//           );
//         default:
//           throw CustomException("sorry! your connection has timed out!");
//       }
//     } catch (e) {
//       throw CustomException("sorry! your connection has timed out!");
//     }
//     // try {
//     //   final r = await call.call();
//     //   return r;
//     // } on DioException catch (e) {
//     //   switch (e.type) {
//     //     case DioExceptionType.cancel:
//     //       throw PrimaryServerException(
//     //         code: 100,
//     //         error: e.toString(),
//     //         message: "request has been canceled",
//     //       );

//     //     case DioExceptionType.connectionTimeout:
//     //       throw PrimaryServerException(
//     //         code: 100,
//     //         error: e.toString(),
//     //         message: "sorry! your connection has timed out!",
//     //       );
//     //     case DioExceptionType.sendTimeout:
//     //       throw PrimaryServerException(
//     //           code: 100,
//     //           error: e.toString(),
//     //           message: "sorry! your send request has timed out!");
//     //     case DioExceptionType.receiveTimeout:
//     //       throw PrimaryServerException(
//     //           code: 100,
//     //           error: e.toString(),
//     //           message: "sorry! your recieve request has timed out!");
//     //     case DioExceptionType.badResponse:
//     //       e.response?.statusCode == 401
//     //           ? resetCredintails()
//     //           : throw PrimaryServerException(
//     //               code: 405,
//     //               error: AppStrings.processFailed.tr,
//     //               message: e.response!.data['message'].toString());

//     //     default:
//     //       throw PrimaryServerException(
//     //           code: 100,
//     //           error: e.toString(),
//     //           message: AppStrings.connectionError.tr);
//     //   }
//     // } catch (e) {
//     //   PrimaryServerException exception = e as PrimaryServerException;

//     //   throw PrimaryServerException(
//     //     code: exception.code,
//     //     error: exception.error,
//     //     message: exception.message,
//     //   );
//     // }
//   }
// }
