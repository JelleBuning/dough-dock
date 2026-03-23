enum DoughType { neapolitan, neapolitanPreferment, newYorkStyle }

extension DoughTypeExtension on DoughType {
  bool get active {
    switch (this) {
      case DoughType.neapolitan:
        return true;
      default:
        return false;
    }
  }

  String displayValue() {
    switch (this) {
      case DoughType.neapolitan:
        return 'Neapolitan';
      case DoughType.neapolitanPreferment:
        return 'Neapolitan (preferment)';
      case DoughType.newYorkStyle:
        return 'New York Style';
    }
  }
}
