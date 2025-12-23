import 'dart:convert';
import 'package:http/http.dart' as http;

class RedditHttpClient {
  final String userAgent = 'Dough dock/1.0 by u/jellebuning';
  final String proxyBaseUrl = 'https://corsproxy.io/?';

  Future<List<Map<String, dynamic>>> fetchSubredditPosts(
    String subreddit,
  ) async {
    final targetUrl = 'https://www.reddit.com/r/$subreddit/new.json';
    final encodedTargetUrl = Uri.encodeComponent(targetUrl);

    final uri = Uri.parse(proxyBaseUrl + encodedTargetUrl);

    final response = await http.get(uri, headers: {'User-Agent': userAgent});

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch posts: ${response.statusCode} ${response.body}',
      );
    }

    final jsonResponse = json.decode(response.body);
    final children = (jsonResponse['data']?['children'] ?? []) as List;
    return children
        .map((item) => item['data'] as Map<String, dynamic>)
        .toList();
  }
}
