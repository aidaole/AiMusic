import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class DioUtils {
  // 私有构造函数
  DioUtils._();

  // 单例模式
  static final DioUtils instance = DioUtils._();

  // dio 实例
  static late final Dio _dio;
  // cookie jar
  static late final PersistCookieJar _cookieJar;

  // 基础配置
  static const int _connectTimeout = 15000; // 15秒
  static const int _receiveTimeout = 15000;
  static const int _sendTimeout = 10000;
  static const String _baseUrl = 'http://localhost:3000/'; // 替换为你的基础URL

  // 初始化 Dio
  static Future<void> init() async {
    // 配置 Dio
    final BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds: _connectTimeout),
      receiveTimeout: const Duration(milliseconds: _receiveTimeout),
      sendTimeout: const Duration(milliseconds: _sendTimeout),
      // 默认请求头
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    // 配置 Cookie
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    _cookieJar = PersistCookieJar(
      storage: FileStorage('$appDocPath/.cookies/'),
    );

    // 添加 Cookie 管理器
    _dio.interceptors.add(CookieManager(_cookieJar));

    // 添加日志拦截器
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    // 添加错误处理拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        // 统一错误处理
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            // 超时错误处理
            break;
          case DioExceptionType.badResponse:
            // 服务器错误处理
            switch (e.response?.statusCode) {
              case 401:
                // 未授权处理
                break;
              case 403:
                // 禁止访问处理
                break;
              case 404:
                // 资源不存在处理
                break;
              case 500:
                // 服务器错误处理
                break;
            }
            break;
          default:
            // 其他错误处理
            break;
        }
        handler.next(e);
      },
    ));
  }

  // GET 请求
  static Future<T?> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // POST 请求
  static Future<T?> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // PUT 请求
  static Future<T?> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // DELETE 请求
  static Future<T?> delete<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // 统一错误处理
  static void _handleError(DioException error) {
    // 这里可以添加统一的错误处理逻辑
    // 比如显示错误提示、日志记录等
    print('请求错误: ${error.message}');
  }

  // 清除所有 Cookie
  static Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
  }

  // 获取所有 Cookie
  static Future<List<Cookie>> loadCookies(Uri uri) async {
    return _cookieJar.loadForRequest(uri);
  }
}
