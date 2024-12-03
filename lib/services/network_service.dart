import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio = Dio();

  NetworkService() {
    // Налаштування тайм-аутів
    _dio.options.connectTimeout = Duration(milliseconds: 5000);  // Тайм-аут для з'єднання (5 секунд)
    _dio.options.receiveTimeout = Duration(milliseconds: 5000);  // Тайм-аут для отримання відповіді (5 секунд)
  }

  // Метод для отримання списку рейсів
  Future<List<dynamic>> fetchFlights() async {
    try {
      final response = await _dio.get(
        'https://api.travelpayouts.com/v1/city-directions?origin=MOW&currency=usd&token=b394d4ddb380612acc8020cb4785aa96',
      );

      // Перевіряємо, чи є в відповіді дані
      if (response.data != null && response.data['data'] != null) {
        // Перетворюємо дані на список
        return response.data['data'].values.toList();
      } else {
        throw Exception('No flight data found in response.');
      }
    } on DioException catch (e) {
      // Обробляємо конкретні помилки Dio
      if (e.type == DioExceptionType.cancel) {
        throw Exception('Request was cancelled.');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      // Загальна обробка будь-яких інших помилок
      throw Exception('Failed to load flights: $e');
    }
  }
}
