import 'package:flutter/material.dart';

class Destination {
  final Icon icon;
  final Icon selectedIcon;
  final String label;
  final String route;
  final Icon? fabIcon;
  final Function()? fabPressed;

  const Destination({
    required this.icon,
    required this.label,
    required this.route,
    required this.selectedIcon,
    this.fabIcon,
    this.fabPressed,
  });
}
