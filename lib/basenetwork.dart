import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projekakhir/fruitmodel.dart';

class BaseNetwork {
  static final String _baseUrl = "https://www.fruityvice.com/api/fruit/all";

  static Future<List<Welcome>> fetchFruits() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((fruit) => Welcome.fromJson(fruit)).toList();
    } else {
      throw Exception('Failed to load fruits');
    }
  }
}
