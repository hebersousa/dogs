
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:typed_data';
import 'dart:convert';

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

  Future<Uint8List> downloadImage(String imageUrl) async {
    var dio = Dio();
    final response = await dio.get(imageUrl, options: Options(responseType: ResponseType.bytes));
    try {
      if (response.statusCode == 200) {
        Uint8List imageBytes = Uint8List.fromList(response.data);
        return Future.value(imageBytes);
      } else {
        throw 'Failed to load image';
      }
    } catch(e) {
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
        return 'Unknown Error';
    }

  }

}