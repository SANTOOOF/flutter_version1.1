import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opttrajflutter/models/route.dart';

class ApiService {
  static const String _envBaseUrl = String.fromEnvironment('API_URL');
  final String _baseUrl =
      _envBaseUrl.isNotEmpty ? _envBaseUrl : 'http://172.30.80.11:31004';

  Future<Route> getRouteById(int routeId) async {
    final response = await http.get(Uri.parse('$_baseUrl/routes/$routeId'));

    if (response.statusCode == 200) {
      return Route.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load route');
    }
  }

  Future<String> getEstimatedArrivalTime(int routeId) async {
    final response = await http.get(Uri.parse('$_baseUrl/routes/eta/$routeId'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load ETA');
    }
  }

  Future<List<Route>> generateRoutes(String circuitType) async {
    final response =
        await http.post(Uri.parse('$_baseUrl/routes/generate?circuitType=$circuitType'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Route.fromJson(json)).toList();
    } else {
      throw Exception('Failed to generate routes');
    }
  }
}
