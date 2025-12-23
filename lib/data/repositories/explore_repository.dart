import 'package:dough_dock/data/services/reddit_http_client.dart';
import 'package:dough_dock/domain/models/post.dart';

class PostRepository {
  PostRepository({required RedditHttpClient redditHttpCLient})
    : _redditHttpCLient = redditHttpCLient;

  final RedditHttpClient _redditHttpCLient;
  List<Post> exploreResults = [];

  Future<void> fetchResults({String subreddit = 'pizza'}) async {
    var results = await _redditHttpCLient.fetchSubredditPosts(subreddit);
    exploreResults =
        results
            .map((item) {
              return Post.fromRedditJson(item);
            })
            .whereType<Post>()
            .toList();
  }
}
