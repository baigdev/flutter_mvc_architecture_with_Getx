import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constant/api_routes.dart';
import '../../local_storage/local_storage.dart';
import 'http_exception.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;
const kServerError =
    'The server encountered an internal error and unable to process your request.';
const kRedirectionError = 'The resource requested has been temporarily moved.';
const kBadRequestError =
    'Your client has issued a malformed or illegal request.';
const kInternetError =
    'There is poor or no internet connection, please try again later.';

class DioClient {
  Dio? _dio;

  LocalStorage localStorage;

  final List<Interceptor>? interceptors;

  DioClient(
    Dio? dio,
    this.localStorage, {
    this.interceptors,
  }) {
    _dio = dio;
    Map<String, dynamic> headers = {};
    if (!localStorage.getUserDetails()) {
      headers = {'Content-Type': 'application/json', 'Accept': '*/*'};
    } else {
      headers = {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer token",
      };
    }
    _dio!
      ..options.baseUrl = ApiConfig.kBaseUrl!
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..options.headers = headers
      ..httpClientAdapter;
    // _dio!.interceptors.add(
    //   RetryInterceptor(
    //     dio: _dio!,
    //     logPrint: log,
    //     retries: 3,
    //     retryDelays: const [
    //       Duration(seconds: 1), // wait 1 sec before first retry
    //       Duration(seconds: 2), // wait 2 sec before second retry
    //       Duration(seconds: 3),
    //     ],
    //   ),
    // );
    if (interceptors?.isNotEmpty ?? false) {
      _dio!.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio!.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }
  }

  Future<dynamic> get(
    String? uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.get(
        uri!,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type ||
          DioErrorType.sendTimeout == e.type) {
        throw HttpException(message: kInternetError, statusCode: 500);
      } else if (DioErrorType.response == e.type) {
        throw HttpException(
          message: e.response!.data['message'],
          statusCode: e.response!.statusCode,
        ); //pass api error
      } else {
        throw HttpException(message: kServerError, statusCode: 500);
      }
    } catch (e) {
      throw HttpException(message: e.toString(), statusCode: 500);
    }
  }

  Future<dynamic> delete(
    String? uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio!.delete(
        uri!,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type ||
          DioErrorType.sendTimeout == e.type) {
        throw HttpException(message: kInternetError, statusCode: 500);
      } else if (DioErrorType.response == e.type) {
        throw HttpException(
            message: e.response!.data['message'],
            statusCode: e.response!.statusCode); //pass api error
      } else {
        throw HttpException(message: kServerError, statusCode: 500);
      }
    } catch (e) {
      throw HttpException(message: e.toString(), statusCode: 500);
    }
  }

  Future<dynamic> post(
    String? uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.post(
        uri!,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type ||
          DioErrorType.sendTimeout == e.type) {
        throw HttpException(message: kInternetError, statusCode: 500);
      } else if (DioErrorType.response == e.type) {
        throw HttpException(
            message: e.response!.data['message'] is List
                ? e.response!.data['message'][0]
                : e.response!.data['message'],
            statusCode: e.response!.statusCode); //pass api error
      } else {
        throw HttpException(message: kServerError, statusCode: 500);
      }
    } catch (e) {
      throw HttpException(message: e.toString(), statusCode: 500);
    }
  }

  Future<dynamic> put(
    String? uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.put(
        uri!,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type ||
          DioErrorType.sendTimeout == e.type) {
        throw HttpException(message: kInternetError, statusCode: 500);
      } else if (DioErrorType.response == e.type) {
        throw HttpException(
            message: e.response!.data['message'],
            statusCode: e.response!.statusCode); //pass api error
      } else {
        throw HttpException(message: kServerError, statusCode: 500);
      }
    } catch (e) {
      throw HttpException(message: e.toString(), statusCode: 500);
    }
  }
}
