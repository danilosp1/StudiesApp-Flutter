import 'package:dio/dio.dart';
import 'models/motd_response.dart';

class ApiService {
  static const String _baseUrl = "https://jsonplaceholder.org/";
  final Dio _dio;

  factory ApiService({Dio? dio}) {
    final dioClient = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

    dioClient.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));

    return ApiService._(dioClient);
  }

  ApiService._(this._dio);

  Future<MotdResponse> getMessageOfTheDay() async {
    try {
      final response = await _dio.get('posts/1');
      return MotdResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Falha ao carregar a mensagem do dia: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro inesperado: $e');
    }
  }
}