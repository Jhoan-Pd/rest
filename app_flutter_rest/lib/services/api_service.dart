import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_flutter_rest/config/constants.dart';
import 'package:app_flutter_rest/models/user.dart';

class ApiService {
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.usersEndpoint}'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<User> getUserById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.usersEndpoint}/$id'),
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }
}
