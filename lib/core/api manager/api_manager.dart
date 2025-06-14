import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  final Dio dio = Dio();
  Future<Response> getData({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return dio.get(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          validateStatus: (status) => true,
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }
}
