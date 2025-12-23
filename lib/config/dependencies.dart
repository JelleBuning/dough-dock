import 'package:dough_dock/data/repositories/explore_repository.dart';
import 'package:dough_dock/data/repositories/pizza_repository.dart';
import 'package:dough_dock/data/repositories/search_repository.dart';
import 'package:dough_dock/data/services/reddit_http_client.dart';
import 'package:dough_dock/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(create: (_) => SearchRepository()),
    Provider(
      create: (_) => PostRepository(redditHttpCLient: RedditHttpClient()),
    ),
    Provider(create: (_) => PizzaRepository()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ];
}
