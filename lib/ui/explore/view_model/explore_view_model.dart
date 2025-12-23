import 'package:dough_dock/data/repositories/explore_repository.dart';
import 'package:dough_dock/data/repositories/search_repository.dart';
import 'package:dough_dock/domain/models/post.dart';
import 'package:flutter/material.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({
    required PostRepository exploreRepository,
    required SearchRepository searchRepository,
  }) : _exploreRepository = exploreRepository,
       _searchRepository = searchRepository;

  final PostRepository _exploreRepository;
  final SearchRepository _searchRepository;

  late List<String> searchResults = [];
  late List<Post> exploreResults = _exploreRepository.exploreResults;

  void fetchExploreData() {
    _exploreRepository.fetchResults().then((_) {
      exploreResults = _exploreRepository.exploreResults;
      notifyListeners();
    });
  }

  void search(String value) {
    searchResults = _searchRepository.fetchResults(value);
    notifyListeners();
  }
}
