import 'package:dough_dock/core/repositories/pizza_repository.dart';
import 'package:dough_dock/core/repositories/session_repository.dart';
import 'package:dough_dock/core/services/dough_calculator.dart';
import 'package:dough_dock/core/services/dough_planner.dart';
import 'package:dough_dock/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(create: (_) => const DoughCalculator()),
    Provider(create: (_) => const DoughPlanner()),
    Provider(create: (_) => PizzaRepository()),
    ChangeNotifierProvider(create: (_) => SessionRepository()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ];
}
