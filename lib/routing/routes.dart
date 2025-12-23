abstract class Routes {
  static Home get home => Home();
}

class Home {
  String get index => '/';
  String get explore => '/explore';
  String get dough => '/dough';
  String get session => '/session';
  String get profile => '/profile';
}
