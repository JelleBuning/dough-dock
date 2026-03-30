abstract class Routes {
  static Home get home => Home();
}

class Home {
  String get index => '/';
  String get dough => '/dough';
  String get toppings => '/toppings';
  String get sessions => '/sessions';
  String get sessionDetailPath => ':id';
  String sessionDetail(int id) => '/sessions/$id';
  String get profile => '/profile';
}
