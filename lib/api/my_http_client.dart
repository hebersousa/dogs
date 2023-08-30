
import 'package:dio/dio.dart';

class MyHttpClient {

  Future<Map<String, dynamic>> get(String path) async {
    try {
      var dio = Dio();
      var response = await dio.get( path );

      return Future.value(response.data);
    } on DioException  catch (e) {

      if (e.response != null) {
        throw e.message.toString();
      } else {
        throw dioToError(e.type);
      }

    } catch (e) {
      rethrow;
    }
  }

  String dioToError(DioExceptionType dioError) {
    switch (dioError) {
      case DioExceptionType.connectionTimeout:
        return 'connection timeout';
      case DioExceptionType.sendTimeout:
        return 'send timeout';
      case DioExceptionType.receiveTimeout:
        return 'receive timeout';
      case DioExceptionType.badCertificate:
        return 'bad certificate';
      case DioExceptionType.badResponse:
        return 'bad response';
      case DioExceptionType.cancel:
        return 'request cancelled';
      case DioExceptionType.connectionError:
        return 'connection error';
      case DioExceptionType.unknown:
        return 'unknown';
    }

  }

}