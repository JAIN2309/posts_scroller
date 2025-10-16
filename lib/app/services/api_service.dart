import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final res = await http.get(Uri.parse('$baseUrl/posts')); // ✅ no backslash
    if (res.statusCode != 200) throw Exception('Failed to load posts');

    // Optional sanity check
    if (!res.headers['content-type']!.contains('application/json')) {
      throw Exception('Invalid JSON response (HTML or text returned)');
    }

    final List decoded = json.decode(res.body);
    return decoded.cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> fetchPostById(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/posts/$id')); // ✅ no backslash
    if (res.statusCode != 200) throw Exception('Failed to load post');

    if (!res.headers['content-type']!.contains('application/json')) {
      throw Exception('Invalid JSON response (HTML or text returned)');
    }

    final Map decoded = json.decode(res.body);
    return decoded.cast<String, dynamic>();
  }
}
