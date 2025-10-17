import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Common headers to mimic a browser request
  Map<String, String> get _headers => {
        'Accept': 'application/json',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
            'AppleWebKit/537.36 (KHTML, like Gecko) '
            'Chrome/121.0.0.0 Safari/537.36',
      };

  /// Fetch all posts
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final url = Uri.parse('$baseUrl/posts');
    print('🔍 [DEBUG] Fetching posts from: $url');

    final res = await http.get(url, headers: _headers);

    print('🌐 [DEBUG] Response status: ${res.statusCode}');
    print('📦 [DEBUG] Content-Type: ${res.headers['content-type']}');

    if (res.statusCode != 200) throw Exception('Failed to load posts');

    if (!res.headers['content-type']!.contains('application/json')) {
      throw Exception('Invalid JSON response (HTML or text returned)');
    }

    final List decoded = json.decode(res.body);
    print('✅ [DEBUG] Loaded ${decoded.length} posts');

    return decoded.cast<Map<String, dynamic>>();
  }

  /// Fetch single post by ID
  Future<Map<String, dynamic>> fetchPostById(int id) async {
    final url = Uri.parse('$baseUrl/posts/$id');
    print('🔍 [DEBUG] Fetching single post from: $url');

    final res = await http.get(url, headers: _headers);

    print('🌐 [DEBUG] Response status: ${res.statusCode}');
    print('📦 [DEBUG] Content-Type: ${res.headers['content-type']}');

    if (res.statusCode != 200) throw Exception('Failed to load post');

    if (!res.headers['content-type']!.contains('application/json')) {
      throw Exception('Invalid JSON response (HTML or text returned)');
    }

    final Map decoded = json.decode(res.body);
    print('✅ [DEBUG] Loaded post: ${decoded['id']}');

    return decoded.cast<String, dynamic>();
  }
}
