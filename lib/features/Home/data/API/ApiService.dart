import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intrazero/features/Home/data/models/home_data_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<HomeProductsModel>> fetchProducts(int page) async {
    try {
      final response = await _dio
          .get('https://fake-store-api.mock.beeceptor.com/api/products');

      switch (response.statusCode) {
        case 200:
          List<HomeProductsModel> products = (response.data as List)
              .map((product) => HomeProductsModel.fromJson(product))
              .toList();
          return products;
        case 400:
          throw Exception('Bad request');
        case 401:
          throw Exception('Unauthorized');
        case 403:
          throw Exception('Forbidden');
        case 404:
          throw Exception('Not found');
        case 500:
          throw Exception('Internal server error');
        default:
          throw Exception(
              'Failed to load products with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<void> placeOrder(Map<String, dynamic> orderPayload) async {
    Dio dio = Dio();

    try {
      Response response = await dio.post(
          'https://fake-store-api.mock.beeceptor.com/api/orders',
          data: orderPayload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Order placed successfully
        print('Order placed: ${response.data}');
      } else {
        // Handle other status codes
        print('Failed to place order: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle Dio exceptions
      print('Dio error: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
    }
  }

  void request() async {
    var uid;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    final response = await _dio.put(
      'https://fake-store-api.mock.beeceptor.com/api/orders',
      data: {
        'user_id': uid,
        "items": [
          {
            "product_id": HomeProductsModel().productId,
            "quantity": HomeProductsModel().quantity,
          }
        ],
      },
    );
  }
}
