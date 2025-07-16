import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studies_app_flutter/data/remote/api_service.dart';
import 'package:studies_app_flutter/data/remote/models/motd_response.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('ApiService', () {
    late MockDio mockDio;
    late ApiService apiService;

    setUp(() {
      mockDio = MockDio();
      when(mockDio.interceptors).thenReturn(Interceptors());
      apiService = ApiService(dio: mockDio);
    });

    test('getMessageOfTheDay returns MotdResponse on success', () async {
      final responseData = {
        'userId': 1,
        'id': 1,
        'title': 'Test MOTD',
        'completed': false
      };
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      final result = await apiService.getMessageOfTheDay();

      expect(result, isA<MotdResponse>());
      expect(result.title, 'Test MOTD');
    });

    test('getMessageOfTheDay throws an exception on DioException', () async {
      when(mockDio.get(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        message: 'Test error',
      ));

      expect(apiService.getMessageOfTheDay(), throwsA(isA<Exception>()));
    });
  });
}