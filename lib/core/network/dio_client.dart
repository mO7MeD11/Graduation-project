import 'package:dio/dio.dart';
import 'package:graduationproject/core/utils/pref_helper.dart';


class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rwv3cgg1-7262.euw.devtunnels.ms',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );
  
  
   DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
