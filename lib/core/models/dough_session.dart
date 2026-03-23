import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/core/models/dough_step.dart';

class DoughSession {
  final DateTime createdAt;

  final int amount;
  final double weightPerPortionG;
  final double waterPercentage;
  final double saltPercentage;
  final double rtLeaveningHours;
  final double rtTemperatureCelsius;
  final YeastType yeastType;
  final DateTime bakeTime;

  final double totalFlour;
  final double totalWater;
  final double totalSalt;
  final double totalYeast;
  final double totalDough;

  final List<DoughStep> steps;

  DoughSession({
    required this.createdAt,
    required this.amount,
    required this.weightPerPortionG,
    required this.waterPercentage,
    required this.saltPercentage,
    required this.rtLeaveningHours,
    required this.rtTemperatureCelsius,
    required this.yeastType,
    required this.bakeTime,
    required this.totalFlour,
    required this.totalWater,
    required this.totalSalt,
    required this.totalYeast,
    required this.totalDough,
    required this.steps,
  });
}
