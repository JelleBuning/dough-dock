class Yeast {
  final String name;
  bool selected;

  Yeast({required this.name, this.selected = false});

  set isSelected(bool value) {
    selected = value;
  }
}
