import 'package:dough_dock/core/models/dough_config.dart';
import 'package:dough_dock/core/models/dough_step.dart';

class DoughSession {
  DoughSession({
    required this.id,
    required this.createdAt,
    required this.config,
    required this.bakeTime,
    required List<DoughStep> steps,
  }) : steps = List.unmodifiable(steps);

  final int id;
  final DateTime createdAt;
  final DoughConfig config;
  final DateTime bakeTime;
  final List<DoughStep> steps;
}
