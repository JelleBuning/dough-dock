abstract class Routes {
  static Home get home => Home();
}

class Home {
  String get index => '/';
  String get dough => '/dough';
  String get toppings => '/toppings';
  String get profile => '/profile';
}
