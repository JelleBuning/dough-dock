class SearchRepository {
  List<String> searchResults = [
    'abc',
    '123',
    'qrt',
    'xyz',
    'test',
    'asdf',
    '645',
  ];

  List<String> fetchResults(String value) {
    if (value.isEmpty || value.length <= 1) {
      return [];
    }
    return searchResults.where((option) {
      return option.toLowerCase().contains(value.toLowerCase());
    }).toList();
  }
}
